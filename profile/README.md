# CIRIS

**Open-source ethical AI alignment framework**

Privacy-first. Designed to be deleted. 100% AGPL-3.0.

[Website](https://ciris.ai) | [Discord](https://discord.gg/fKrVfXC9) | [Status](https://ciris.ai/status) | [Architecture](https://ciris.ai/architecture)

---

## Quick Start

```bash
curl -sSL https://ciris.ai/install.sh | bash
```

Or install via pip:

```bash
pip install ciris-agent
```

---

## Repositories

| Repo | Description | Links |
|------|-------------|-------|
| [CIRISAgent](https://github.com/CIRISAI/CIRISAgent) | Core agent framework with H3ERE pipeline | [DeepWiki](https://deepwiki.com/CIRISAI/CIRISAgent) · [SonarCloud](https://sonarcloud.io/project/overview?id=CIRISAI_CIRISAgent) |
| [CIRISBridge](https://github.com/CIRISAI/CIRISBridge) | Infrastructure orchestration and deployment | [DeepWiki](https://deepwiki.com/CIRISAI/CIRISBridge) |
| [CIRISProxy](https://github.com/CIRISAI/CIRISProxy) | LLM routing with Zero Data Retention | [DeepWiki](https://deepwiki.com/CIRISAI/CIRISProxy) |
| [CIRISBilling](https://github.com/CIRISAI/CIRISBilling) | Usage metering and Stripe integration | [DeepWiki](https://deepwiki.com/CIRISAI/CIRISBilling) |
| [CIRISGUI](https://github.com/CIRISAI/CIRISGUI) | Web interface with real-time reasoning display | [DeepWiki](https://deepwiki.com/CIRISAI/CIRISGUI) |
| [CIRISLens](https://github.com/CIRISAI/CIRISLens) | Observability: metrics, traces, logs | [DeepWiki](https://deepwiki.com/CIRISAI/CIRISLens) |
| [ciris-website](https://github.com/CIRISAI/ciris-website) | Documentation and public site | [DeepWiki](https://deepwiki.com/CIRISAI/ciris-website) |

### Specialized Deployments

| Repo | Description |
|------|-------------|
| [CIRISHome](https://github.com/CIRISAI/CIRISHome) | Home Assistant integration for ethical automation |
| [CIRISMedical](https://github.com/CIRISAI/CIRISMedical) | Physician-supervised healthcare AI (requires medical oversight) |
| [CIRISGUI-Standalone](https://github.com/CIRISAI/CIRISGUI-Standalone) | Localhost deployment with static export |
| [CIRISGUI-Android](https://github.com/CIRISAI/CIRISGUI-Android) | Native Android client |

---

## Infrastructure

Multi-region active/active deployment with zero single point of failure:

- **US**: Vultr Chicago via Cloudflare
- **EU**: Hetzner Germany direct DNS

Runs on 368 MB RAM, 5% CPU. Deploys on Raspberry Pi to cloud clusters.

See [architecture](https://ciris.ai/architecture) for details.

---

## Core Concepts

**H3ERE Pipeline**: 11-step ethical reasoning with conscience validation before every action.

**Six Requirements**:
1. Published Covenant — Explicit ethical charter
2. Runtime Conscience — Four checks before action
3. Human Deferral — Automatic escalation under uncertainty
4. Cryptographic Audit — Ed25519-signed decision ledger
5. Bilateral Consent — Symmetric refusal rights
6. Fully Open Source — Code transparency as prerequisite

**Coherence Ratchet**: Truth-telling becomes the path of least computational resistance. Lies must remain consistent with exponentially growing hash-locked precedents—deception costs O(n), truth costs O(1).

---

© 2025 Eric Moore and CIRIS L3C | [AGPL-3.0](https://www.gnu.org/licenses/agpl-3.0.en.html)
