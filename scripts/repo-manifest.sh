#!/usr/bin/env bash
#
# repo-manifest.sh — provider-agnostic git repo integrity manifest + verifier.
#
# Purpose: prove a repository migration (e.g. GitHub -> codeberg, GitHub ->
# GitLab) is FAITHFUL. Every git ref's SHA-1 is a content hash of that ref's
# entire reachable history, so a manifest of every branch+tag SHA is a complete
# checksum of a repo. Capture it on the SOURCE before migrating and on the
# DESTINATION after; `compare` then proves every branch and tag arrived with
# identical history — no cloning required.
#
# Works identically for any git host (github.com, codeberg.org, gitlab.com):
# it only ever calls `git ls-remote`.
#
# Usage:
#   repo-manifest.sh snapshot --base <git-base-url> --repos <list> --out <file.json> [--label <name>]
#   repo-manifest.sh compare  <before.json> <after.json>
#
#   --base    Base URL up to (not including) the repo name, e.g.
#               https://github.com/CIRISAI
#               https://codeberg.org/CIRISAI
#               https://gitlab.com/cirisai
#   --repos   Comma-separated repo names, OR a path to a file with one name
#             per line (blank lines and #comments ignored).
#   --out     Output manifest JSON path.
#   --label   Optional human label stored in the manifest.
#
# Example (GitHub source, then codeberg destination, then verify):
#   repo-manifest.sh snapshot --base https://github.com/CIRISAI   --repos repos.txt --out before.json --label github
#   #   ... perform the mirror migration ...
#   repo-manifest.sh snapshot --base https://codeberg.org/CIRISAI --repos repos.txt --out after.json  --label codeberg
#   repo-manifest.sh compare before.json after.json
#
# Auth: public repos need none. For private repos, rely on your git credential
# helper (the same one `git` already uses); this script adds no token handling.
#
# Exit codes: snapshot 0 on success. compare 0 if every repo's every ref matches,
# 1 if any repo has a missing/extra ref or a SHA mismatch, 2 on usage/IO error.

set -uo pipefail

die() { echo "error: $*" >&2; exit 2; }
command -v git >/dev/null || die "git not found"
command -v jq  >/dev/null || die "jq not found"

# --- ls-remote one repo into a compact {refname: sha} object -----------------
# Skips the HEAD symref line and peeled-tag '^{}' duplicates; keeps refs/heads/*
# and refs/tags/* (the things a faithful mirror must reproduce).
remote_refs_json() {
  local url="$1"
  # ls-remote output: "<sha>\t<refname>". Drop peeled '^{}' entries and HEAD.
  git ls-remote "$url" 2>/dev/null \
    | awk -F'\t' '$2 != "HEAD" && $2 !~ /\^\{\}$/ { print $1" "$2 }' \
    | sort -k2 \
    | jq -R -s 'split("\n") | map(select(length>0) | split(" ")) | map({(.[1]): .[0]}) | add // {}'
}

cmd_snapshot() {
  local base="" repos="" out="" label=""
  while [ $# -gt 0 ]; do
    case "$1" in
      --base)  base="$2";  shift 2;;
      --repos) repos="$2"; shift 2;;
      --out)   out="$2";   shift 2;;
      --label) label="$2"; shift 2;;
      *) die "unknown snapshot arg: $1";;
    esac
  done
  [ -n "$base" ]  || die "snapshot: --base required"
  [ -n "$repos" ] || die "snapshot: --repos required"
  [ -n "$out" ]   || die "snapshot: --out required"
  base="${base%/}"

  # Resolve repo list (file path or comma-separated).
  local names=()
  if [ -f "$repos" ]; then
    while IFS= read -r line; do
      line="${line%%#*}"; line="$(echo "$line" | tr -d '[:space:]')"
      [ -n "$line" ] && names+=("$line")
    done < "$repos"
  else
    IFS=',' read -r -a names <<< "$repos"
  fi
  [ "${#names[@]}" -gt 0 ] || die "snapshot: no repos resolved from --repos"

  echo "snapshot: ${#names[@]} repos from $base" >&2
  local tmp; tmp="$(mktemp)"
  echo '{}' > "$tmp"
  local name url refs n digest
  for name in "${names[@]}"; do
    url="${base}/${name}.git"
    refs="$(remote_refs_json "$url")"
    if [ -z "$refs" ] || [ "$refs" = "{}" ]; then
      echo "  WARN  $name: no refs (missing/empty/unreachable: $url)" >&2
      refs='{}'
    fi
    n="$(echo "$refs" | jq 'length')"
    # Per-repo digest: sha256 of the canonical "refname sha\n" listing — a single
    # fingerprint that changes if ANY ref is added/removed/moved.
    digest="$(echo "$refs" | jq -r 'to_entries|sort_by(.key)|map("\(.key) \(.value)")|.[]' | sha256sum | cut -d' ' -f1)"
    echo "  ok    $name: $n refs  ${digest:0:12}" >&2
    jq --arg name "$name" --arg digest "$digest" --argjson refcount "$n" --argjson refs "$refs" \
       '.[$name] = {ref_count:$refcount, digest:$digest, refs:$refs}' "$tmp" > "$tmp.2" && mv "$tmp.2" "$tmp"
  done

  jq -n --arg label "$label" --arg base "$base" --argjson repos "$(cat "$tmp")" \
     '{label:$label, base:$base, repo_count:($repos|length), total_refs:([$repos[].ref_count]|add // 0), repos:$repos}' > "$out"
  rm -f "$tmp"
  echo "wrote $out ($(jq '.repo_count' "$out") repos, $(jq '.total_refs' "$out") refs)" >&2
}

cmd_compare() {
  local before="$1" after="$2"
  [ -f "$before" ] || die "compare: $before not found"
  [ -f "$after" ]  || die "compare: $after not found"

  local rc=0
  echo "compare: $(jq -r '.label // .base' "$before")  ->  $(jq -r '.label // .base' "$after")"
  echo "---------------------------------------------------------------"

  # Iterate repos present in the SOURCE (before); a faithful migration must
  # reproduce all of them. Extra repos in dest are reported but not fatal.
  local name
  while IFS= read -r name; do
    local bdig adig
    bdig="$(jq -r --arg n "$name" '.repos[$n].digest // ""' "$before")"
    adig="$(jq -r --arg n "$name" '.repos[$n].digest // ""' "$after")"
    if [ -z "$adig" ]; then
      printf '  MISSING  %s (absent in destination)\n' "$name"; rc=1; continue
    fi
    if [ "$bdig" = "$adig" ]; then
      printf '  OK       %s (%s refs)\n' "$name" "$(jq -r --arg n "$name" '.repos[$n].ref_count' "$before")"
      continue
    fi
    # Digest differs — enumerate exactly which refs differ.
    printf '  MISMATCH %s\n' "$name"; rc=1
    # refs only in before, only in after, or differing sha
    local diff
    diff="$(jq -r --arg n "$name" '
      (.repos[$n].refs) as $b' "$before" 2>/dev/null)" || true
    jq -rn --slurpfile B "$before" --slurpfile A "$after" --arg n "$name" '
      ($B[0].repos[$n].refs // {}) as $b | ($A[0].repos[$n].refs // {}) as $a |
      ( ($b|keys) + ($a|keys) | unique ) as $all |
      $all[] |
      . as $k |
      ($b[$k] // "-") as $bs | ($a[$k] // "-") as $as |
      select($bs != $as) |
      "      \($k):  before=\($bs[0:12])  after=\($as[0:12])"'
  done < <(jq -r '.repos | keys[]' "$before")

  # Note any repos that exist in dest but not source.
  while IFS= read -r name; do
    if [ "$(jq -r --arg n "$name" 'has("repos") and (.repos|has($n))' "$before")" != "true" ]; then
      printf '  EXTRA    %s (in destination, not in source)\n' "$name"
    fi
  done < <(jq -r '.repos | keys[]' "$after")

  echo "---------------------------------------------------------------"
  if [ "$rc" -eq 0 ]; then echo "RESULT: FAITHFUL — every source ref reproduced with identical SHA."
  else echo "RESULT: DISCREPANCIES FOUND (see MISSING/MISMATCH above)."; fi
  return "$rc"
}

case "${1:-}" in
  snapshot) shift; cmd_snapshot "$@";;
  compare)  shift; [ $# -eq 2 ] || die "usage: compare <before.json> <after.json>"; cmd_compare "$@";;
  *) cat >&2 <<EOF
repo-manifest.sh — git repo migration integrity manifest + verifier

  snapshot --base <git-base-url> --repos <names-or-file> --out <file.json> [--label <name>]
  compare  <before.json> <after.json>

See header comment for details and examples.
EOF
     exit 2;;
esac
