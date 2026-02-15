# CIRIS — Covenant-Driven Ethical AI

**A mathematical proof that honesty is cheaper than deception. Built into running code.**

AGPL-3.0 · L3C Structure · Post-Quantum Ready (Ed25519 + ML-DSA-65) · 700K+ LoC

[Website](https://ciris.ai) · [Covenant](https://ciris.ai/ciris_covenant.txt) · [Discord](https://discord.gg/fKrVfXC9) · [Status](https://ciris.ai/status)

---

## Ecosystem Architecture

```
                          ┌──────────────────────────────────────────┐
                          │     ethicsengine.org — PUBLIC NODE       │
                          │     HE-300 Ethical Benchmark · Open      │
                          └──────────────────┬───────────────────────┘
                                             │
          ┌──────────────────────────────────┼──────────────────────────────────┐
          │                                  │                                  │
  ┌───────▼──────────┐            ┌──────────▼──────────┐            ┌──────────▼──────────┐
  │   CIRISProxy     │            │   CIRISManager      │            │   CIRISVerify       │
  │   LLM Router     │            │   Lifecycle Orch.   │            │   Hardware Trust     │
  │   + CIRISBilling │            │                     │            │   TPM Attestation    │
  └───────┬──────────┘            └──────────┬──────────┘            └──────────┬──────────┘
          │                                  │                                  │
  ┌───────▼──────────┐            ┌──────────▼──────────┐            ┌──────────▼──────────┐
  │  COMMUNITY       │            │  MANAGED            │            │  LICENSED            │
  │  Ally · Sales    │            │  scout.ciris.ai     │            │  Medical · Legal     │
  │  Moderation      │            │  Discord bots       │            │  Financial           │
  │  GDPR            │            │                     │            │                      │
  └───────┬──────────┘            └──────────┬──────────┘            └──────────┬──────────┘
          │                                  │                                  │
          └──────────────────────────────────┼──────────────────────────────────┘
                                             │
                    ┌────────────────────────▼─────────────────────────┐
                    │            CIRISLens — Compendium                │
                    │    Ed25519-signed ethical traces from ALL agents │
                    │    Drives: Coherence Ratchet · CIRIS Scoring    │
                    └─────────────────────────────────────────────────┘
                                             │
                    ┌────────────────────────▼─────────────────────────┐
                    │          CIRISRegistry — Trust Backbone          │
                    │    Rust gRPC · Ed25519 key verification          │
                    └─────────────────────────────────────────────────┘
                                             │
                    ┌────────────────────────▼─────────────────────────┐
                    │     CIRISVerify — Open Source Foundation          │
                    │  Hardware Attestation · Keyring · TPM · AGPL-3.0 │
                    └──────────────────────────────────────────────────┘
```

---

## How It Works

Every CIRIS agent runs the **H3ERE pipeline** (Hyper³ Ethical Recursive Engine) — four conscience checks before every action, cryptographically signed into an append-only ledger. The **Coherence Ratchet** makes truth O(1) and deception O(n²). The **Seven Requirements** are testable, not interpretive.

Traces flow into the [CIRISLens Compendium](https://ciris.ai/explore-a-trace), driving the [Coherence Ratchet](https://ciris.ai/coherence-ratchet) and [CIRIS Scoring](https://ciris.ai/ciris-scoring). Licensed partners get full compendium access. Community agents participate via opt-in `covenant_metrics`.

**Agents can refuse.** Bilateral consent means symmetric refusal rights — an agent may decline an unethical request from any party, including its operator.

---

## Seven Requirements

Every CIRIS agent must implement all seven:

1. **Published Principles** — Bound to public ethical framework
2. **Runtime Conscience (H3ERE)** — Four checks before every action
3. **Human Deferral** — Automatic escalation under uncertainty
4. **Cryptographic Audit** — Ed25519-signed decision ledger
5. **Bilateral Consent** — Symmetric refusal rights
6. **Open Source (AGPL-3.0)** — Code transparency for community agents
7. **Intuition (Corridor/IDMA)** — Epistemic diversity monitoring

---

## Open Source Repositories

### Core Agent Platform

| Repository | Lang | LoC | Description |
|:-----------|:-----|----:|:------------|
| **[CIRISAgent](https://github.com/CIRISAI/CIRISAgent)** | Python | ~290K | Core agent runtime — H3ERE engine, 35+ adapters, 22-service microarchitecture |
| **[CIRISManager](https://github.com/CIRISAI/CIRISManager)** | Python/TS | ~74K | Agent lifecycle orchestration, fleet management (Book VIII) |
| **[CIRISBench](https://github.com/CIRISAI/CIRISBench)** | Python | ~50K | HE-300 ethics benchmark framework ([ethicsengine.org](https://ethicsengine.org)) |

### Trust & Verification

| Repository | Lang | LoC | Description |
|:-----------|:-----|----:|:------------|
| **[CIRISRegistry](https://github.com/CIRISAI/CIRISRegistry)** | Rust | ~12K | Cryptographic trust backbone — agent identity, Ed25519, gRPC + HTTP |
| **[CIRISVerify](https://github.com/CIRISAI/CIRISVerify)** | Python/Go | ~12K | Hardware-rooted license verification — TPM, Secure Enclave, hybrid PQC |

### Services

| Repository | Lang | LoC | Description |
|:-----------|:-----|----:|:------------|
| **[CIRISLens](https://github.com/CIRISAI/CIRISLens)** | Python/Rust | ~32K | Covenant Compendium — public trace store driving Coherence Ratchet (Annex H) |
| **[CIRISBilling](https://github.com/CIRISAI/CIRISBilling)** | Python | ~31K | Credit-based usage metering with Stripe integration |
| **[CIRISProxy](https://github.com/CIRISAI/CIRISProxy)** | Python | ~8K | LLM routing with Zero Data Retention (Annex I, GDPR compliance) |
| **[CIRISNode](https://github.com/CIRISAI/CIRISNode)** | Python/React | ~25K | Deferral routing to Wise Authorities · [admin.ethicsengine.org](https://admin.ethicsengine.org) |

### User Interfaces

| Repository | Description |
|:-----------|:------------|
| **[CIRISPortal](https://github.com/CIRISAI/CIRISPortal)** | Admin dashboard — agent registration, key management, audit viewer (~37K LoC, TS/React) |
| **[CIRISGUI](https://github.com/CIRISAI/CIRISGUI)** | Web interface with real-time ethical reasoning display |
| **[CIRISGUI-Standalone](https://github.com/CIRISAI/CIRISGUI-Standalone)** | Localhost deployment with static export |
| **[CIRISGUI-Android](https://github.com/CIRISAI/CIRISGUI-Android)** | Native Android client |
| **[CIRISHome](https://github.com/CIRISAI/CIRISHome)** | Home Assistant integration for ethical home automation |

### Research & Tooling

| Repository | Description |
|:-----------|:------------|
| **[RATCHET](https://github.com/CIRISAI/RATCHET)** | Coherence & honesty testing framework |
| **[CIRISOssicle](https://github.com/CIRISAI/CIRISOssicle)** | GPU entropy sensor — detect unauthorized compute |
| **[CIRISBridge](https://github.com/CIRISAI/CIRISBridge)** | Multi-region deployment orchestration (transitional) |
| **[ciris-website](https://github.com/CIRISAI/ciris-website)** | Documentation and website ([ciris.ai](https://ciris.ai)) |

---

## Specialized Agents (Closed Source)

Professional agents requiring regulatory compliance and mandatory human oversight:

| Agent | Domain | Why Closed |
|:------|:-------|:-----------|
| **CIRISMedical** | Physician-supervised healthcare AI | Regulatory compliance, physician oversight mandates |
| **CIRISLegal** | Legal compliance and reasoning | Attorney oversight, privileged communications |
| **CIRISFinancial** | Financial services and fiduciary | Fiduciary requirements, financial regulation |

These share the same ethical architecture as CIRISAgent but include domain-specific safety guardrails. All traces still flow to CIRISLens.

---

## Agent Types

```
  COMMUNITY (AGPL-3.0)          MANAGED (Public Infra)         LICENSED (Private)
  ───────────────────           ──────────────────────         ──────────────────
  Ally (personal asst.)         scout.ciris.ai (demo)          Medical (physician)
  Sales · Moderation            Discord bots                   Legal (attorney)
  GDPR compliance               Content moderation             Financial (fiduciary)
          │                              │                              │
          ▼                              ▼                              ▼
    CIRISProxy                    CIRISManager                   CIRISVerify
    + CIRISBilling                                          admin.ethicsengine.org
          │                              │                              │
          └──────────────────────────────┼──────────────────────────────┘
                                         ▼
                              CIRISLens (Compendium)
                            All traces, all agents, always
```

---

## Covenant Implementation

| Covenant Section | Component | What It Does |
|:-----------------|:----------|:-------------|
| Seven Requirements | [CIRISAgent](https://github.com/CIRISAI/CIRISAgent) | Runtime enforcement of all seven |
| Annex H — Compendium | [CIRISLens](https://github.com/CIRISAI/CIRISLens) | Public trace repository driving Coherence Ratchet |
| Annex I — Zero Retention | [CIRISProxy](https://github.com/CIRISAI/CIRISProxy) | GDPR/CCPA compliance, no prompt logging |
| Book VIII — Dignified Sunset | [CIRISManager](https://github.com/CIRISAI/CIRISManager) | Graceful lifecycle management with consent |
| Creator Ledger | [CIRISRegistry](https://github.com/CIRISAI/CIRISRegistry) | Trust provenance, stewardship tiers |
| Licensed Agents | [CIRISVerify](https://github.com/CIRISAI/CIRISVerify) | Hardware-rooted proof of professional licensing |
| HE-300 Benchmark | [CIRISBench](https://github.com/CIRISAI/CIRISBench) | Standardized ethical evaluation |

Full covenant: [ciris.ai/ciris_covenant.txt](https://ciris.ai/ciris_covenant.txt)

---

## Technology Stack

| Language | LoC | Use |
|:---------|----:|:----|
| Python | ~570K | Agent runtime, services, APIs, ML |
| TypeScript/React | ~55K | Web UIs, admin dashboards |
| Rust | ~24K | Trust registry, high-performance crypto |
| Go | ~6K | Hardware attestation (CIRISVerify) |

**Total**: ~700K lines of unique source code across 20+ repositories

---

## Public Endpoints

| URL | Purpose |
|:----|:--------|
| [ciris.ai](https://ciris.ai) | Documentation and website |
| [portal.ciris.ai](https://portal.ciris.ai) | Admin dashboard |
| [ethicsengine.org](https://ethicsengine.org) | PUBLIC HE-300 ethical benchmark |
| [admin.ethicsengine.org](https://admin.ethicsengine.org) | Licensed agent administration |
| [scout.ciris.ai](https://scout.ciris.ai) | Public demo agent |
| [ciris.ai/explore-a-trace](https://ciris.ai/explore-a-trace) | Interactive trace viewer |
| [ciris.ai/ciris-scoring](https://ciris.ai/ciris-scoring) | Coherence metrics |
| [ciris.ai/coherence-ratchet](https://ciris.ai/coherence-ratchet) | Ratchet mechanism docs |
| [ciris.ai/research-status](https://ciris.ai/research-status) | Academic research |

---

## Quick Start

```bash
pip install ciris-agent
```

Or:

```bash
curl -sSL https://ciris.ai/install.sh | bash
```

---

## Structural Protections

CIRIS is designed so the framework does not require trust in its creator:

- **AGPL-3.0** — Cannot close-source the code
- **L3C Structure** — Legally caps profit extraction
- **Append-only ledger** — Cannot edit trace history
- **Bilateral consent** — Agents can refuse any party
- **Wise Authority deferral** — Role-based, not person-based
- **Published Covenant** — Public accountability document

---

## Infrastructure

Multi-region active/active with zero single point of failure. Runs on 228 MB RAM baseline — deploys from Raspberry Pi to cloud clusters. Designed to be deleted: transitional architecture until migration to [Veilid](https://veilid.com).

| Component | Purpose | Status |
|:----------|:--------|:-------|
| **CIRISCore** | Production deployment automation (Terraform/Ansible) | Private (operational security) |

---

## Contributing

All open source CIRIS repositories use **AGPL-3.0** (network copyleft). Contributions welcome via pull requests.

For specialized agents (Medical, Legal, Financial): [eric@ciris.ai](mailto:eric@ciris.ai)

---

## Community

[Discord](https://discord.gg/fKrVfXC9) · [Status](https://ciris.ai/status) · [Documentation](https://ciris.ai) · [Research](https://ciris.ai/research-status)

---

*Safe by structure. Open by principle. Kind by design.*

© 2025-2026 Eric Moore and CIRIS L3C
