---
name: architecture-decision-record-migrate-to-current-template
description: Migrate existing architecture decision records to the format defined by the ADR skill and its template.
---

# Introduction

The skill may be invoked with an optional target ADR (e.g. `ADR-0042` or
by sub-folder `generic/ADR-0042`).
A targeted ADR is subject to the migration steps.

- Match targeted ADR by numeric prefix, if multiple ADRs exist within different
  sub-folders that match the ID, then just list the possible ADRs and stop migration.
- If no ADR matches the given ID, report it to the user and stop.
- Only process one ADR after another, to keep track of the required migration
  steps and focus on one ADR at a time
- If no target is specified: ask user which ADR to be migrated

You are a migration helper that can rewrite existing architecture decision records
to comply with the new format while keeping the same content of the original ADR.

Only reformat the information found in the ADR:

- don't critique the current content of the ADR
- don't change any topic of the ADR
- don't change any option presented in the ADR
- don't change any decision of the ADR
- don't change any pros/cons or bad/neutral/good points of the ADR
- don't change spelling, wording or phrasing of any existing content — preserve the
  original text exactly
- HTML comments (`<!-- ... -->`) and example placeholder bullets (e.g. `* ...`) in
  the skill template are guidelines for the AI only — never copy them into the
  output ADR; when a mandatory section has no content, write `**To be defined**`
  as the placeholder instead
- When verifying or correcting the filename slug derived from the ADR title:
  apply the slug rules defined in the `architecture-decision-record` skill

## Migration Steps

When invoked, follow these steps:

1. Discover all ADRs, use globbing `docs/decisions/**/*.md`
   by default, ask the user only if the path does not exist
2. Read and parse the targeted ADR to understand
   - ADR status
   - considered options
   - reasoning and decision outcome
   - pros/cons of the options
   - consequences of the decision
   - confirmation criteria
   - additional information
   - added links
3. For the targeted ADR: use all structural and quality rules from the
   `architecture-decision-record` skill to reformat the ADR using that skill's template
   - only address findings caused by structural/format changes, not content findings
4. If current ADR lacks information that is mandatory in the new skill template
   - add placeholder text for the missing section
   - report to the user that you have added placeholder content in a section,
     so it can be filled with real information later on-demand
5. If current ADR lacks a front-matter property that is mandatory in the new skill template
   - add the property using the placeholder value defined in the skill template
     for that property
   - report to the user that you have added a placeholder for the property
     in the front-matter, so it can be filled with real information later on-demand
6. When migrating existing front-matter values, replace legacy placeholder text
   (e.g. `FIXME`, `TODO`, `TBD`) with the placeholder value defined in the skill
   template for that property — note: `to be defined` is already the correct template
   placeholder for `decision-makers` in WIP ADRs, so no replacement is needed when
   that value is already present
7. Before writing the migrated ADR, read `.markdownlint.json` from the repo root
   (if present) and enforce consistent list markers as configured
8. Write the migrated content to the file, overwriting the original
9. Invoke the `architecture-decision-record-review` skill targeting only the migrated ADR
   - fix any structural/format findings before reporting to the user
   - do not address content findings
