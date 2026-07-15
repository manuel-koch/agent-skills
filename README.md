# Skills for AI Agents

## Architecture Decision Record

**[architecture-decision-record](./skills/architecture-decision-record/SKILL.md)** guides AI in
writing and maintaining Architecture Decision Records (ADRs) using a customised MADR bare template.
Covers the full ADR lifecycle: creating, updating, superseding, and status transitions. Defines slug
rules, front-matter fields, section structure, and quality rules. Acts as the sole authoritative
reference for ADR format — all other ADR skills defer to it.

**[architecture-decision-record-review](./skills/architecture-decision-record-review/SKILL.md)**
reviews ADRs for structural conformance to the `architecture-decision-record` skill template and for
cross-ADR consistency. Can target a specific ADR by number or sub-folder, or review all ADRs at
once. Checks WIP placeholders, HTML comments, markdownlint rules, and supersession chain integrity.
Reports findings per ADR with `[high]`/`[low]` severity, separated by `---`.

**[architecture-decision-record-review-code](./skills/architecture-decision-record-review-code/SKILL.md)**
reviews source code against the project's ADRs. Applies `accepted` ADR decisions as high-priority
findings and `draft`/`proposed` ADRs as low-priority early warnings. Follows supersession chains to
the authoritative ADR. Ignores `rejected` and `deprecated` ADRs.

**[architecture-decision-record-migrate-to-current-template](./skills/architecture-decision-record-migrate-to-current-template/SKILL.md)**
migrates an existing ADR to the current skill template format without changing any content,
decisions, or phrasing. Adds placeholder text for missing mandatory sections and properties, and
replaces legacy placeholder values. Invokes the `architecture-decision-record-review` skill after
migration to validate the result.

## Markdown Docs Review

**[markdown-docs-review](./skills/markdown-docs-review/SKILL.md)** audits all Markdown (`*.md`)
documentation files in the project for consistency, duplication, broken links, and contradictions.
Checks single-source-of-truth violations, verifies relative links and anchors, reconciles
contradictions between files, and fixes all findings in place. Iterates until a full pass produces
zero fixable findings.

## Financial Research Local

**[financial-research-local](./skills/financial-research-local/SKILL.md)** helps search and
interpret local financial datasets (bank statements, credit card transactions, investment portfolios).
Guides agents on folder structure navigation, German CSV conventions (semicolon separators, comma
decimals, date formats), encoding handling, and privacy-safe output formatting. Covers ambiguous
dates, amount sign conventions, and institution-specific data patterns.

## Product Buying Guide

**[product-buying-guide](./skills/product-buying-guide/SKILL.md)** guides users through informed
purchase decisions by systematically researching and comparing products. Follows a structured
workflow: check existing research, define requirements, gather candidates, compare systematically,
and recommend. Features a language gate (responds in the user's query language), market-specific
price research (EU-wide coverage with German market focus), total cost of ownership calculations,
and structured output with citations. Covers professional test sites, price comparison portals,
and fallback strategies for blocked sources.

## Plan Software Change

**[plan-software-change](./skills/plan-software-change/SKILL.md)** creates a structured,
self-contained implementation plan for introducing new features, fixing bugs, or researching a
topic. Reads from a user-provided input file (or inline requirements) and writes the plan to a
sidecar file (e.g. `#123.md` → `#123-plan.md`). Actively searches the codebase for referenced
files, conventions (`AGENTS.md`, `CONTRIBUTING.md`, ADRs, style guides), and existing patterns to
ground the plan in reality. Output sections cover Context, Implementation Plan, Proposed
Improvements (optional), Consistency Issues (optional), Implementation Hints, and Open Questions
(optional). Open questions are resolved iteratively: answers are removed from the questions list
and incorporated into Implementation Hints. The plan is designed to be handed off to a fresh agent
session without any additional context.
