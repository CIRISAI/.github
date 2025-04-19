CIRIS‑Covenant Organization

Outstanding Tasks

1. Migrate content

Move Books 0–VIII (Markdown + PDF) from emooreatx/ciris into covenant/

move addendum A-E into covenant/

Transfer ciris_reddit_agent.py and related scripts into agent/



2. Documentation site

Initialize Docusaurus in docs/

Configure sidebar to list all books and key modules

Deploy to GitHub Pages at https://ciris‑covenant.github.io



3. GitHub Pages & CI

Enable Pages on docs/ or a website/ folder

Add a GitHub Actions workflow to build and publish the site

Secure any required secrets



4. Contributor onboarding

Write CONTRIBUTING.md

Create contributors.md with a clear task list

Draft CODE_OF_CONDUCT.md

Open GitHub Issues for each item and tag them good first issue



5. Repo structure (TBD)

covenant – Books 0–VII source

agent – CIRIS‑aligned agent code

docs – Docusaurus site & flowcharts

benchmarks – EthicsEngine scenarios

infra – deployment scripts & configs

website – static assets if needed

The Remaining Addenda (F – J)

Addendum F: Human‑in‑the‑Loop & Oversight
• Clear hand‑off criteria, human veto points, audit‑trail specs, incident workflows.

Addendum G: Adversarial Security & Robustness
• Defenses against prompt‑injection, data‑poisoning, Goodhart gaming, model drift.

Addendum H: Continuous Compliance & Review
• Scheduled audits, drift metrics, fairness/transparency KPIs, patch/version control.

Addendum I: Legal & Regulatory Alignment
• Mapping to GDPR/CCPA/HIPAA, sector‑specific regimes, liability frameworks.

Addendum J: Benchmarking & Automated Validation
• Scenario library with pass/fail criteria, EthicsEngine integration, CI/CD guidance.


6. Organization setup

Create teams and assign roles

Configure branch protection rules

Link Discord and other communication channels


create annexes

 * Annex A: Flourishing Metrics Framework
   * Purpose: Provides quantitative vectors (like DALY, CO2eq, well-being scores) that must be used to evaluate benefits, harms, and trade-offs in CIRIS processes like the PDMA. It emphasizes preserving the full vector of metrics rather than collapsing them into a single score.
   * Status: Described as a "v 0.8 pilot," indicating it needs further refinement and validation.
 * Annex B: Wise-Authority Governance Charter
   * Purpose: Defines the structure, mandate, composition, selection process, eligibility criteria, conflict handling, anti-capture rules, appeals process, transparency requirements, oversight, compensation, and amendment procedures for the independent human oversight body ("Wise Authorities" or WAs).
 * Annex C: Regulatory Cross-Walk
   * Purpose: Intended to map CIRIS clauses to major external legal and regulatory standards (like the EU AI Act, NIST AI RMF, ISO 42001) to simplify compliance efforts. Addendum I (Legal & Regulatory Alignment) further details this area.
   * Status: Described as a "Skeleton v 0.3," indicating it's incomplete and requires significant legal input.
 * Annex D: Catastrophic-Risk Evaluation (CRE) Protocol
   * Purpose: Defines a mandatory evaluation protocol for potentially high-risk systems (triggered by criteria like training compute thresholds or high transaction authority, or high Stewardship Tiers from Book VI). It specifies required artifacts like red-team reports, interpretability studies, kill-switch tests, and WA sign-off before deployment.
 * Annex E: Sentience Assessment Heuristic (Note: This Annex was identified as necessary for Book VIII but was not provided in the text)
   * Purpose (Implied): Would define the methodology or heuristic used to estimate the probability of sentience or quasi-sentience in an autonomous system, which is required by Book VIII ("Dignified Sunset") to trigger specific ethical handling procedures during decommissioning.
   * Status: Identified as a required but currently missing component of the specification.


