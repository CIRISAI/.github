#!/usr/bin/env bash
# code-census.sh — de-duplicated, test/generated-excluded source line count by language.
# Walks ./clones/*, counts hand-written CODE only: excludes data/markup, tests,
# vendored deps, generated code, and build output; de-duplicates identical file
# CONTENT across all repos (so GUI forks / vendored copies count once).
set -uo pipefail
ROOT="${1:-clones}"
FORMAT="human"; [ "${2:-}" = "--md" ] && FORMAT="md"   # --md emits a generated markdown table

# Map extension/filename -> language bucket. Only real code; data/markup omitted.
lang_of() {
  case "$1" in
    *.py) echo Python;; *.rs) echo Rust;;
    *.ts) echo TypeScript;; *.tsx) echo TypeScript;;
    *.js|*.mjs|*.cjs) echo JavaScript;; *.jsx) echo JavaScript;;
    *.kt|*.kts) echo Kotlin;; *.swift) echo Swift;; *.lean) echo Lean;;
    *.sql) echo SQL;; *.sh|*.bash) echo Shell;;
    *.hcl|*.tf) echo HCL;; *.proto) echo Protobuf;; *.go) echo Go;;
    *.c|*.h) echo C;; *.cc|*.cpp|*.cxx|*.hpp) echo C++;;
    *.java) echo Java;; *.rb) echo Ruby;; *.m|*.mm) echo Objective-C;;
    *.dart) echo Dart;; *.scala) echo Scala;; *.ex|*.exs) echo Elixir;;
    */Dockerfile|Dockerfile) echo Dockerfile;; */Makefile|Makefile) echo Makefile;;
    *) echo "";;
  esac
}

# Path is a test / generated / vendored / build artifact -> skip.
is_excluded() {
  local p="${1,,}"   # lowercase
  case "/$p" in
    */test/*|*/tests/*|*/__tests__/*|*/spec/*|*/specs/*|*/e2e/*|*/fixtures/*|*/testdata/*|*/__mocks__/*) return 0;;
    */vendor/*|*/third_party/*|*/third-party/*|*/node_modules/*|*/.venv/*|*/venv/*|*/.git/*) return 0;;
    */generated/*|*/generated-api/*|*/.next/*|*/dist/*|*/build/*|*/target/*|*/out/*|*/__pycache__/*|*/.tox/*) return 0;;
  esac
  case "$p" in
    test_*|*_test.py|*_test.go|*_test.rs|*.test.ts|*.test.tsx|*.test.js|*.spec.ts|*.spec.tsx|*.spec.js|*test.kt|*tests.kt|*test.swift|*tests.swift) return 0;;
    *_pb2.py|*_pb2_grpc.py|*.pb.go|*.pb.rs|*.g.dart|*.freezed.dart) return 0;;  # generated
  esac
  return 1
}

# Emit "sha1<TAB>lines<TAB>lang<TAB>repo" for every counted file.
emit() {
  local repo f lang sha lines
  for d in "$ROOT"/*/; do
    repo="$(basename "$d")"
    while IFS= read -r -d '' f; do
      is_excluded "$f" && continue
      lang="$(lang_of "$f")"; [ -z "$lang" ] && continue
      sha="$(sha1sum "$f" 2>/dev/null | cut -d' ' -f1)"; [ -z "$sha" ] && continue
      lines="$(wc -l < "$f" 2>/dev/null)"
      printf '%s\t%s\t%s\t%s\n' "$sha" "${lines:-0}" "$lang" "$repo"
    done < <(find "$d" -type f \( -name '*.py' -o -name '*.rs' -o -name '*.ts' -o -name '*.tsx' \
              -o -name '*.js' -o -name '*.mjs' -o -name '*.cjs' -o -name '*.jsx' -o -name '*.kt' -o -name '*.kts' \
              -o -name '*.swift' -o -name '*.lean' -o -name '*.sql' -o -name '*.sh' -o -name '*.bash' \
              -o -name '*.hcl' -o -name '*.tf' -o -name '*.proto' -o -name '*.go' -o -name '*.c' -o -name '*.h' \
              -o -name '*.cc' -o -name '*.cpp' -o -name '*.cxx' -o -name '*.hpp' -o -name '*.java' -o -name '*.rb' \
              -o -name '*.m' -o -name '*.mm' -o -name '*.dart' -o -name '*.scala' -o -name '*.ex' -o -name '*.exs' \
              -o -name 'Dockerfile' -o -name 'Makefile' \) -print0 2>/dev/null)
  done
}

ALL="$(emit)"
DEDUP="$(echo "$ALL" | sort -u -t$'\t' -k1,1)"     # identical content counted once
raw_total=$(echo "$ALL"   | awk -F'\t' '{s+=$2} END{print s+0}')
dedup_total=$(echo "$DEDUP" | awk -F'\t' '{s+=$2} END{print s+0}')
repo_count=$(find "$ROOT" -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d ' ')
# group tiny languages (<1000 deduped lines) into "Other" for the headline table
lang_table=$(echo "$DEDUP" | awk -F'\t' '{a[$3]+=$2} END{for(k in a) printf "%s\t%d\n",k,a[k]}' | sort -t$'\t' -k2 -nr)

if [ "$FORMAT" = "md" ]; then
  # Machine-generated markdown — this is what populates CODE_STATS.md / README.
  echo "$lang_table" | awk -F'\t' '
    BEGIN{ printf "| Language | Lines |\n|:---|---:|\n" }
    { n=$2; o=""; while(n>0){r=n%1000;n=int(n/1000); o=(n>0)?sprintf(",%03d%s",r,o):sprintf("%d%s",r,o)} printf "| %s | %s |\n", $1, o }
  '
  # comma-format the total
  tfmt=$(echo "$dedup_total" | awk '{n=$1;o="";while(n>0){r=n%1000;n=int(n/1000);o=(n>0)?sprintf(",%03d%s",r,o):sprintf("%d%s",r,o)}print o}')
  echo "| **Total** | **$tfmt** |"
  echo
  echo "_De-duplicated source lines across $repo_count public repositories — tests, generated code, vendored deps, and data/markup excluded. Generated $(date -u +%Y-%m-%d) by \`scripts/code-census.sh\`; do not edit by hand._"
  # machine-readable trailer (parsed by gen-stats.sh to update the README headline)
  echo "<!-- CENSUS_TOTAL=$dedup_total REPOS=$repo_count -->"
  exit 0
fi

echo "=== RAW (every counted file, pre-content-dedup) by language ==="
echo "$ALL" | awk -F'\t' '{a[$3]+=$2} END{for(k in a) printf "%-14s %10d\n",k,a[k]}' | sort -k2 -nr
echo "RAW total: $raw_total"
echo
echo "=== DE-DUPLICATED (identical file content counted once, across all repos) by language ==="
echo "$lang_table" | awk -F'\t' '{printf "%-14s %10d\n",$1,$2}'
echo "DEDUP total: $dedup_total"
echo
echo "=== duplication removed: $((raw_total - dedup_total)) lines ($(awk -v r="$raw_total" -v d="$dedup_total" 'BEGIN{if(r>0)printf "%.1f",(r-d)*100/r; else print 0}')%) across $repo_count repos ==="
