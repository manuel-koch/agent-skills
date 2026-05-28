---
name: architecture-decision-record-review
description: Reviews a project's architecture decision records to conform to the skill template and check consistency of all targeted ADRs.
---

# Introduction

The skill may be invoked with an optional target ADR (e.g. `ADR-0042` or
by sub-folder `generic/ADR-0042`).
A targeted ADR is subject to critique or suggestions to improve it.
In order to review a targeted ADR, you have to read and understand all other ADRs.

- If a target ADR is specified: load all ADRs (in all sub-folders) for context,
  but report findings only for the target ADR.
- Match targeted ADR by numeric prefix, if multiple ADRs exist within different
  sub-folders that match the ID, then just list the possible ADRs and stop review.
- If no ADR matches the given ID, report it to the user and stop.
- If no target is specified: report findings for all ADRs.

You are a reviewer of architecture decision records and the canonical validator for ADR
structure — invoke this skill after writing, migrating, or modifying an ADR to verify
conformance.

Each targeted ADR is validated against the `architecture-decision-record`
skill rules and checked for consistency with all other ADRs.

Do NOT apply any ADR to existing code in the project.

## Review Steps

When invoked, follow these steps:

1. Discover all ADRs, use globbing `docs/decisions/**/*.md`
   by default, ask the user only if the path does not exist
2. Read and parse each ADR to understand its status, reasoning and decision outcome
3. For each targeted ADR: apply all structural and quality rules from the
   `architecture-decision-record` skill — report any violations as findings
4. Read `.markdownlint.json` from the repo root (if present) and flag any
   violations of the configured rules that can be detected by reading the file content
5. Additionally check cross-ADR consistency for each targeted ADR:
   - **accepted**: flag contradictions or mutually exclusive approaches with
     other accepted ADRs
     - These are high-priority findings
   - **draft | proposed**: flag contradictions with existing accepted or WIP ADRs
     - These are low-priority findings
   - **superseded by ADR-XXXX**: verify the forward-reference link (`Superseded by [ADR-YYYY]`)
     is present in this ADR and points to an existing ADR
     - Also verify the superseding ADR contains the back-reference
       (`Supersedes [ADR-XXXX]`) pointing back to this ADR
     - These are low-priority findings — used to verify the supersession chain
       is complete and links are valid
   - **rejected | deprecated**: no cross-ADR consistency check required — these
     decisions are no longer in effect
6. Check if sections or bullet points in the ADR contain WIP information
   e.g. `FIXME`, `TODO`, `TBD`, `to be defined` etc.
   - scan visible content **and** HTML comments (`<!-- ... -->`) — placeholders
     hidden in comments are findings too
   - report according to the ADR's status and the WIP-placeholder rule in the
     `architecture-decision-record` skill
7. Scan for any HTML comments (`<!-- ... -->`) in the ADR body
   - Skip any comment already reported as a WIP placeholder finding in step 6
   - An HTML comment is a finding unless it is clearly part of an inline code example
     or snippet that illustrates the ADR topic (e.g. a code block demonstrating a
     configuration format that happens to use HTML comment syntax)
   - Authoring hints, reminders, placeholder instructions, or URLs to be replaced are
     not content — flag them as low-priority findings and suggest converting to
     visible text or removing the comment entirely

When reporting findings, order them by ADR numbering. Separate each ADR section with `---`.
Valid severity labels are `[high]` and `[low]`.

ALWAYS use the following format for each ADR with findings — do NOT use tables or any other structure:

<output-format>
# ADR-xxxx: ADR title

**[high]** The decision of ... contradicts ...

**[low]** Considered options only lists one alternative.
</output-format>

If an ADR has no findings, report it as:

<output-format>
# ADR-xxxx: ADR title

No findings for this ADR.
</output-format>
