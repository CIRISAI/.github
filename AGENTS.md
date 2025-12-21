# CIRIS .github Repository - Agent Instructions

This repo contains org-level GitHub configuration: profile README, reusable workflows, and shared CI tooling.

## Before Working on Issues

Complete these steps in order:

### 1. Read Core Documents (CIRISAgent repo)

```bash
# The Covenant - ethical foundation
gh api repos/CIRISAI/CIRISAgent/contents/COVENANT.md --jq '.content' | base64 -d

# Comprehensive Guide - full system overview
gh api repos/CIRISAI/CIRISAgent/contents/CIRIS_COMPREHENSIVE_GUIDE.md --jq '.content' | base64 -d
```

### 2. Query DeepWiki for Context

Use the DeepWiki MCP tool to understand the CIRIS ecosystem:

```
mcp__deepwiki__ask_question
- repoName: "CIRISAI/CIRISAgent"
- question: "What is the H3ERE architecture and how do the DMAs work?"

mcp__deepwiki__ask_question
- repoName: "CIRISAI/CIRISBridge"  
- question: "What is the multi-region infrastructure setup?"
```

Key repos to query:
- `CIRISAI/CIRISAgent` - Core agent framework
- `CIRISAI/CIRISBridge` - Infrastructure/deployment
- `CIRISAI/ciris-website` - Website and public docs

### 3. Read Website Architecture

The website has the current public-facing architecture documentation:

```bash
# Check the architecture page for current style/content
gh api repos/CIRISAI/ciris-website/contents/src/app/architecture/page.tsx --jq '.content' | base64 -d
```

The org README should match this modern, clean style - not the old academic verbose style.

### 4. Review Open Issues

```bash
gh issue list --repo CIRISAI/.github
```

Current priorities:
- **#1** - Modernize org profile README (match ciris.ai/architecture style)
- **#2** - Reusable CI workflows for installation testing

## Style Guidelines

When updating the org README:
- **Concise** over verbose
- **Links** over inline explanations
- **Tables** for repository listings
- **Modern** terminology (not "3×3×3×3 Ethical Recursive Engine")
- Match https://ciris.ai/architecture tone

## Key Facts

- All repos use **AGPL-3.0** (network copyleft)
- Infrastructure is **"designed to be deleted"** (transitional until Veilid)
- Multi-region: US (Vultr/Cloudflare) + EU (Hetzner/direct)
- Install command: `curl -sSL https://ciris.ai/install.sh | bash`
- CIRIS is an **L3C** (Low-Profit LLC), donations not tax-deductible

## Repo Links

| Repo | Purpose |
|------|---------|
| [CIRISAgent](https://github.com/CIRISAI/CIRISAgent) | Core agent |
| [CIRISBridge](https://github.com/CIRISAI/CIRISBridge) | Infrastructure |
| [CIRISBilling](https://github.com/CIRISAI/CIRISBilling) | Credits/payments |
| [CIRISProxy](https://github.com/CIRISAI/CIRISProxy) | LLM routing (ZDR) |
| [CIRISLens](https://github.com/CIRISAI/CIRISLens) | Observability |
| [ciris-website](https://github.com/CIRISAI/ciris-website) | Website |

## Related Issues

- CIRISAgent#552 - `verify_install.sh` (dependency for #2)
