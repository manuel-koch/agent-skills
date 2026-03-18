---
name: architecture-decision-record
description: Write and maintain Architecture Decision Records (ADRs) following best practices for technical decision documentation. Use when documenting significant technical decisions, reviewing past architect...
---

# Architecture Decision Record (ADR)

## Instructions

- Use **Architecture Decision Record** to document decisions made for the project
- ADR is written in markdown format
- If not otherwise stated, write ADR in english language
- ADR filename uses dash pattern `<4_digit_number>-<dash-slug-adr-title>.md`.
  Filename must match the ADR title using the dash pattern with lowercase characters.
  When deriving the slug: lowercase all words, replace spaces with `-`, transliterate special characters to their ASCII equivalents (e.g. `&` → `and`, `+` → `plus`, `/` → `or`), drop any remaining non-alphanumeric characters that have no clear ASCII equivalent, and collapse any consecutive `-` into a single `-`.
  e.g. title "Use Conventional Commits for Commit Messages" → filename `0001-use-conventional-commits-for-commit-messages.md`
  e.g. title "Stage & Prod Separation" → filename `0007-stage-and-prod-separation.md`
  When checking for a mismatch, apply the slug rules to the title first, then compare the result to the filename — transliterations like `&` → `and` are expected and correct, not a finding.
  A mismatch between the derived slug and the filename is a low-priority review finding.
- new ADR filenames use a number, greater than any existing ADR in current folder
- ADR can be placed in a topic related subfolder under project directory `/docs/decisions/<topic-sub-folder>`
- The template used by this skill is at [ADR template](./references/0000-a-markdown-adr-template.md) — this is the sole authoritative template; use it for all structure and formatting decisions
  - The project template is based on [MADR adr-template-bare.md](https://github.com/adr/madr/blob/4.0.0/template/adr-template-bare.md) but has been customized; the upstream MADR template is for historical reference only and must NOT be used to infer structure or fill in gaps
- ADR has a title
- ADR has a status and a date when that status was decided
  - new ADR always created with status "draft"
  - valid statuses: `draft` | `proposed` | `rejected` | `accepted` | `deprecated` | `superseded by ADR-XXXX`
  - **WIP statuses** (decision not yet finalized): `draft`, `proposed`
  - **Terminal statuses** (decision finalized): `rejected`, `accepted`, `deprecated`, `superseded by ADR-XXXX`
- Check whether ADR has WIP content ( that actually looks like placeholder text that has to be replaced by real content ) in front-matter, sections, paragraphs or bullet points
  - **Before scanning:** `decision-makers: to be defined` in a WIP-status ADR is the expected template placeholder — skip this field entirely, do NOT report it as a finding under any circumstances
  - WIP placeholder phrases to detect everywhere else: `FIXME`, `TODO`, `TBD`, `to be defined` etc.
  - If ADR status is WIP, report detected placeholder content as a low-priority finding
  - If ADR status is terminal, report detected placeholder content as a high priority finding
- Do NOT compare the format or structure of one ADR against other ADRs in the repository — the skill template is the sole authority; an ADR that complies with the template is correct regardless of how other ADRs are formatted
- when referring to existing local documents/images within markdown syntax, use relative paths: `./filename.md` for files in the same folder, `../other-folder/filename.md` for files in sibling folders — always use relative paths, never absolute paths
- ADR has a context and a problem statement to frame the topic of the decision
- ADR provides reasonable information of viable options to decide on
  - ADR lists at least two alternative options to choose — the `Considered Options` section contains only the option names as bullet points; inline descriptions are not required here and their absence is not a finding
  - The sub-headings under `Pros and Cons of the Options` must match the corresponding option name in `Considered Options` verbatim — a difference in wording or casing is a low-priority review finding
- ADR describes what the outcome of the decision is
- ADR decision drivers are addressed by the selected decision
  - When reviewing an ADR that has a `Decision Drivers` section, verify that the Decision Outcome or Consequences explicitly addresses each listed driver — an unaddressed driver is a low-priority finding
- ADR describes what good, neutral or bad consequences result when the decision is effective
- ADR lists status and date in the markdown front-matter
- ADR lists persons or groups in the markdown front-matter property `decision-makers` that decided on the ADR
  - for WIP-status ADRs: use `to be defined` as the placeholder value, or leave empty — both are acceptable
  - for terminal-status ADRs: must contain real names of persons or teams — a placeholder value is a high priority finding
- ADR may list persons or groups in the markdown front-matter property `consulted` that were consulted to write the ADR
  - if there were no consultants, leave the property empty in the front-matter
  - the key must be present in the front-matter even when empty; a missing key is a low-priority finding, an empty value is not
- ADR may list persons or groups in the markdown front-matter property `informed` that were informed of the ADR ( e.g. after the decision was made )
  - if there was nobody informed, leave the property empty in the front-matter
  - the key must be present in the front-matter even when empty; a missing key is a low-priority finding, an empty value is not
- Ensure that the structure of the ADR contains the main topics in the following order ( see the skill's ADR template as a reference )
  - **Title** (required)
  - If the ADR has been superseded, place the "Superseded by" note here incl. a link to the new ADR
  - If this ADR supersedes another, place the "Supersedes" note here incl. a link to the original ADR
  - **Context and Problem Statement** (required)
  - **Decision Drivers** (optional)
  - **Considered Options** (required)
  - **Decision Outcome** (required)
  - **Consequences** (required)
  - **Confirmation** (required)
  - **Pros and Cons of the Options** (required)
  - **More Information** (optional)
  - **Links** (optional)
- Optional sections must only be included when they have meaningful content — omit them entirely otherwise
- When reviewing an ADR, check whether other ADRs in the project are clearly related (same system component, direct dependency, or supersession chain); if the `Links` section is absent and such ADRs exist, report this as a low-priority finding and list which ADRs should be linked
- When reviewing an ADR, read `.markdownlint.json` from the repo root (if present) and flag any violations of the configured rules that can be detected by reading the file content
- When producing an ADR from the template, do NOT copy any HTML comments or example placeholder content into the output — the template's inline comments identify exactly what must not be copied

### Updating or Revising an Existing ADR

The correct approach depends on the current status of the ADR being changed.

**Edit in-place** (the ADR has not yet been formally committed to):

| Status | Rationale |
|---|---|
| `draft` | Work in progress by definition — no external dependency on its content yet |
| `proposed` | Under review but not yet decided — content is still expected to change |
| `rejected` | Never put into effect — no auditable record depends on its content |

When editing in-place: update the content directly and adjust the `date` field to today's date if the status changes. No new file is created.

**Create a new superseding ADR** (the ADR has been formally committed to):

| Status | Rationale |
|---|---|
| `accepted` | The decision is in effect and part of the auditable record — in-place edits would silently destroy traceability |
| `deprecated` | Was previously accepted; its history must remain intact |
| `superseded by ADR-XXXX` | Historical record — content must not be changed; create a new ADR if the superseding decision itself needs revision |

When a new ADR supersedes an accepted or deprecated one, apply the following steps:

1. **Create the new ADR** with the next available number and status `draft`.
   Include a back-reference link in the document body directly below the title heading:
   ```
   Supersedes [ADR-XXXX](./XXXX-original-adr-name.md).
   ```
2. **Update the original ADR**: change its status to `superseded by ADR-YYYY` and update the `date` field to today's date (the date the supersession takes effect).
   Add a forward-reference link in the document body directly below the title heading:
   ```
   Superseded by [ADR-YYYY](./YYYY-new-adr-name.md).
   ```
   Do not alter any other content of the original ADR — its historical record must remain intact.
3. **Consistency check**: check whether all ADRs referenced by the new ADR contain inconsistencies or contradict it.
4. Only promote the new ADR from `draft` to `accepted` on explicit instruction to do so.
5. When promoting an ADR to a terminal status (`rejected`, `accepted`, or `deprecated`) ensure that markdown front-matter **decision-makers** has real names of persons or teams instead of any placeholder value (e.g. "FIXME", "TODO", "to be defined"). The `proposed` status does not require this check — the decision has not yet been made and deciders may not be known.

## Examples

- A template for an ADR can be found [template](./references/0000-a-markdown-adr-template.md)
