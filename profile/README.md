# CIRIS

**Open-source ethical AI alignment framework**

Privacy-first. Network copyleft (AGPL-3.0). No data retention.

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

## Open Source Repositories

### Agent Framework
| Repository | Language | LoC | Description |
|------------|----------|-----|-------------|
| [CIRISAgent](https://github.com/CIRISAI/CIRISAgent) | Python | 516K | Core agent runtime with H3ERE ethical reasoning (22-service microarchitecture) |
| [CIRISVerify](https://github.com/CIRISAI/CIRISVerify) | Python/Go | 12K | Hardware-rooted license verification (TPM/Secure Enclave, hybrid PQC) |

### Trust Infrastructure
| Repository | Language | LoC | Description |
|------------|----------|-----|-------------|
| [CIRISRegistry](https://github.com/CIRISAI/CIRISRegistry) | Rust | 11K | Trust registry with cryptographic agent identity (gRPC + HTTP, Ed25519) |
| [CIRISNode](https://github.com/CIRISAI/CIRISNode) | Python/React | 21K | Licensed agent administration ([admin.ethicsengine.org](https://admin.ethicsengine.org)) |
| [CIRISPortal](https://github.com/CIRISAI/CIRISPortal) | TypeScript/React | 24K | Admin dashboard for agent registration and key management |

### Services
| Repository | Language | LoC | Description |
|------------|----------|-----|-------------|
| [CIRISProxy](https://github.com/CIRISAI/CIRISProxy) | Python | 8K | LLM routing with Zero Data Retention (Annex I GDPR compliance) |
| [CIRISBilling](https://github.com/CIRISAI/CIRISBilling) | Python | 31K | Credit-based usage metering with Stripe integration |
| [CIRISLens](https://github.com/CIRISAI/CIRISLens) | Python/Rust | 32K | Public covenant trace compendium driving Coherence Ratchet (Annex H) |
| [CIRISManager](https://github.com/CIRISAI/CIRISManager) | Python/TypeScript | 74K | Agent lifecycle management and orchestration (Book VIII) |

### Infrastructure
| Repository | Language | Description |
|------------|----------|-------------|
| [CIRISBridge](https://github.com/CIRISAI/CIRISBridge) | Python/Ansible | Multi-region deployment orchestration for services layer |
| [ciris-website](https://github.com/CIRISAI/ciris-website) | TypeScript/React | Public documentation and website (ciris.ai) |

### User Interfaces
| Repository | Description |
|------------|-------------|
| [CIRISGUI](https://github.com/CIRISAI/CIRISGUI) | Web interface with real-time ethical reasoning display |
| [CIRISGUI-Standalone](https://github.com/CIRISAI/CIRISGUI-Standalone) | Localhost deployment with static export |
| [CIRISGUI-Android](https://github.com/CIRISAI/CIRISGUI-Android) | Native Android client |
| [CIRISHome](https://github.com/CIRISAI/CIRISHome) | Home Assistant integration for ethical home automation |

---

## Specialized Agents (Closed Source)

Professional-grade agents requiring stewardship accountability and regulatory compliance:

| Agent | Domain | Status |
|-------|--------|--------|
| **CIRISMedical** | Physician-supervised healthcare AI | Private (licensed deployment only) |
| **CIRISLegal** | Compliance verification and legal reasoning | Private (licensed deployment only) |
| **CIRISFinancial** | Financial services and investment guidance | Private (licensed deployment only) |

These specialized agents are **not open source** due to regulatory requirements, stewardship accountability mandates, and the need for mandatory human oversight in high-stakes domains. They share the same ethical architecture as CIRISAgent but include domain-specific safety guardrails and professional oversight protocols.

**Licensed agents** submit covenant traces to [admin.ethicsengine.org](https://admin.ethicsengine.org) for validation and compendium inclusion.

**Community agents** (CIRISCare) can opt-in to send traces to CIRISLens via the covenant_metrics adapter, contributing to the public Coherence Ratchet without requiring licensing.

---

## Infrastructure (Closed Source)

| Component | Purpose | Status |
|-----------|---------|--------|
| **CIRISCore** | Production deployment automation (Terraform/Ansible) | Private (operational security) |

CIRISCore contains deployment configurations, infrastructure-as-code, and operational procedures for production servers. Keeping this private prevents exposure of production topology, credentials, and security configurations.

---

## Architecture

### System Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                      Public Endpoints                            │
├─────────────────────────────────────────────────────────────────┤
│   ciris.ai              │  portal.ciris.ai                       │
│   (Website)             │  (Admin UI)                            │
│                         │                                        │
│   admin.ethicsengine.org│  ciris.ai/explore-a-trace             │
│   (Licensed Node)       │  (Public Trace Explorer)               │
└──────┬──────────────────┴───────────┬────────────────────────────┘
       │                              │
       │   ┌──────────────────────────▼──────────────┐
       │   │   CIRISRegistry (Rust gRPC)             │
       │   │   Trust backbone                        │
       │   │   Ed25519 key verification              │
       │   └──────────────────────┬──────────────────┘
       │                          │
   ┌───▼───────┐    ┌─────────────▼──────────┐
   │  Website  │    │   CIRISPortal          │
   │  (Docs)   │    │   (Admin)              │
   └───────────┘    └────────────────────────┘
                              │
                    ┌─────────▼──────────────────────────┐
                    │     CIRISAgent Runtime              │
                    │     H3ERE Pipeline                  │
                    │     Ed25519 Signing                 │
                    │     22-Service Architecture         │
                    └────┬───────────────┬────────────────┘
                         │               │
              ┌──────────┘               └──────────┐
              │                                     │
       ┌──────▼─────────┐                  ┌───────▼────────┐
       │  CIRISProxy    │                  │  CIRISLens     │
       │  (LLM Router)  │                  │  (Compendium)  │
       │  Zero Data     │                  │  Drives:       │
       │  Retention     │                  │  - Ratchet     │
       └────────┬───────┘                  │  - Scoring     │
                │                          └────────────────┘
       ┌────────▼─────────┐
       │  CIRISBilling    │      Licensed agents → admin.ethicsengine.org
       │  (Credits/Usage) │      Community agents → opt-in to CIRISLens
       └──────────────────┘
                │
       ┌────────▼─────────┐
       │  CIRISVerify     │
       │  (License Check) │
       │  Hardware TPM    │
       └──────────────────┘
```

### 22-Service Microarchitecture

CIRISAgent implements transparency through a modular architecture organized into three strata:

**Graph Services (6)**: Memory, Config, Audit, Telemetry, Incident, Time-Series
**Infrastructure Services (11)**: Resource Monitor, Auth, Init/Shutdown, Time, Database, Secrets, Consent, Runtime Control, Task Scheduling
**Governance Services (4)**: Wise Authority, Visibility, Self-Observation, Adaptive Filter
**Core Tool Service (1)**: Unified tool interface

Each service has a single responsibility and can be independently tested, updated, and audited.

### Infrastructure Deployment

Multi-region active/active with zero single point of failure:

- **US**: Vultr Chicago via Cloudflare
- **EU**: Hetzner Germany direct DNS

Runs on 228 MB RAM baseline. Deploys from Raspberry Pi to cloud clusters.

---

## Technology Stack

| Language | Total LoC | Primary Use |
|----------|-----------|-------------|
| **Python** | ~690K | Agent runtime, APIs, services |
| **TypeScript/React** | ~28K | Web UIs, admin dashboards |
| **Rust** | ~11K | Trust registry, high-performance services |
| **Go/Python** | ~12K | Hardware-rooted license verification |
| **Infrastructure** | - | Terraform, Ansible, Docker |

**Total Open Source**: ~740K lines of code across 20+ repositories

---

## Core Concepts

### H3ERE Pipeline (Hyper³ Ethical Recursive Engine)

11-step ethical reasoning with conscience validation before every action:

1. **Observation** - Perceive context
2. **Contextualization** - Map to ethical framework
3. **Rationale** - Generate action candidates
4. **Conscience** - Four mandatory checks (entropy, coherence, optimization veto, epistemic humility)
5. **Execution** - Take action with audit trail

### Seven Requirements

Every CIRIS agent must implement:

1. **Published Principles** - Bound to public ethical framework (Beneficence, Non-maleficence, Integrity, Transparency, Autonomy, Justice)
2. **Runtime Conscience** - Four checks before every action
3. **Human Deferral** - Automatic escalation under uncertainty
4. **Cryptographic Audit** - Ed25519-signed decision ledger
5. **Bilateral Consent** - Symmetric refusal rights (agent can refuse unethical requests)
6. **Open Source (AGPL-3.0)** - Code transparency as prerequisite for community agents
7. **Intuition (Corridor Maintenance)** - IDMA monitors epistemic diversity, flags decisions based on correlated sources

### Coherence Ratchet

Truth-telling becomes the path of least computational resistance. Lies must remain consistent with exponentially growing hash-locked precedents—deception costs O(n²), truth costs O(1).

Covenant traces from agents flow into the **CIRISLens Compendium**, driving:
- [Coherence Ratchet mechanism](https://ciris.ai/coherence-ratchet)
- [CIRIS Scoring system](https://ciris.ai/ciris-scoring)
- [Public trace exploration](https://ciris.ai/explore-a-trace)

**Licensed partners** can access the full compendium for research and training purposes.

---

## Covenant Implementation

| Component | Covenant Function | Implementation |
|-----------|-------------------|----------------|
| CIRISNode | Licensed agent administration | admin.ethicsengine.org coordination |
| CIRISRegistry | **Creator Ledger** - Stewardship tiers | Trust provenance, agent identity |
| CIRISLens | **Annex H** - Public compendium | Trace repository driving Coherence Ratchet |
| CIRISProxy | **Annex I** - Zero Data Retention | GDPR/CCPA compliance, no prompt logging |
| CIRISManager | **Book VIII** - Dignified Sunset | Graceful lifecycle management with consent |
| CIRISVerify | **Licensed Agents** - Hardware attestation | TPM-rooted proof of professional licensing |

Full covenant: [ciris.ai/ciris_covenant.txt](https://ciris.ai/ciris_covenant.txt)

---

## Contributing

Open source CIRIS repositories use **AGPL-3.0** (network copyleft). Contributions welcome via pull requests.

Infrastructure is "designed to be deleted" - transitional architecture until migration to [Veilid](https://veilid.com).

**For specialized agents** (CIRISMedical, CIRISLegal, CIRISFinancial): These are closed source due to regulatory requirements. Inquiries: [eric@ciris.ai](mailto:eric@ciris.ai)

---

## Community

- **Discord**: [discord.gg/fKrVfXC9](https://discord.gg/fKrVfXC9)
- **Status**: [ciris.ai/status](https://ciris.ai/status)
- **Documentation**: [ciris.ai](https://ciris.ai)

---

## Research & Validation

**Public Trace Exploration**:
- [Explore a Trace](https://ciris.ai/explore-a-trace) - Interactive trace viewer
- [CIRIS Scoring](https://ciris.ai/ciris-scoring) - Coherence metrics
- [Coherence Ratchet](https://ciris.ai/coherence-ratchet) - Mechanism overview

**Academic Research**: [ciris.ai/research-status](https://ciris.ai/research-status)

**Licensed Partner Access**: Full compendium available for research and training

Recent validations:
- ✅ Coherence Ratchet mechanism operational
- ✅ Ed25519 signature chain verified
- ✅ Human deferral workflows tested end-to-end
- ✅ Covenant trace compendium driving scoring system

---

© 2025-2026 Eric Moore and CIRIS L3C | [AGPL-3.0](https://www.gnu.org/licenses/agpl-3.0.en.html)
