# Skills and Agents for AI

## Architecture Decision Record

* Skill [architecture-decision-record](./skills/architecture-decision-record/SKILL.md) guides AI in writing and maintaining Architecture Decision Records (ADRs) following the [MADR bare template](https://github.com/adr/madr/blob/4.0.0/template/adr-template-bare.md). Covers the full ADR lifecycle: creating, updating, superseding, and status transitions.
* Agent [review-adr](./agents/review-adr.md) reviews ADRs for structural conformance to the skill template and cross-ADR consistency. Can target a specific ADR by number or review all ADRs at once. Reports findings by priority (high/low).
* Agent [review-code-with-adr](./agents/review-code-with-adr.md) reviews source code against the project's ADRs. Applies `accepted` ADRs as hard violations (high priority) and `draft`/`proposed` ADRs as early warnings (low priority). Ignores `rejected` and `deprecated` ADRs.
* Agent [migrate-adr-to-current-template](./agents/migrate-adr-to-current-template.md) reformats an existing ADR to comply with the current skill template without changing any content, decisions, or phrasing. Runs agent `review-adr` after migration to validate the result.

## Markdown Docs Review

* Skill [markdown-docs-review](./skills/markdown-docs-review/SKILL.md) audits all Markdown (`*.md`) documentation files in the project for consistency, duplication, broken links, and contradictions. Checks single-source-of-truth violations, verifies relative links and anchors, reconciles contradictions between files, and fixes all findings in place. Iterates until a full pass produces zero fixable findings.
