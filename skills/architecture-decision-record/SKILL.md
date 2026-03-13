---
name: architecture-decision-record
description: Write and maintain Architecture Decision Records (ADRs) following best practices for technical decision documentation. Use when documenting significant technical decisions, reviewing past architect...
---

# Architecture Decision Record (ADR)

## Instructions

- Use **Architecture Decision Record** to document decisions made for the project
- ADR is written in markdown format
- If not otherwise stated, write ADR in english language
- ADR filename uses dash pattern `<4_digit_number>-<dash-slug-adr-title>.md`
- new ADR filenames use a numerical number, greater than any existing ADR in current folder
- ADR can be placed in a topic related subfolder under project directory `/docs/decisions/<topic-sub-folder>`
- For details of ADR see [MADR similar decision record](https://github.com/adr/madr/blob/4.0.0/docs/decisions/0000-use-markdown-architectural-decision-records.md).
- ADR has a title
- ADR has a status and a date when that status was decided
  - new ADR always created with status "draft"
  - valid statuses: `draft` | `proposed` | `rejected` | `accepted` | `deprecated` | `superseded by [ADR-XXXX](link)`
- when referring to existing local documents/images within markdown syntax, always use the "./" prefix for all relative local paths
- ADR has a context and a problem statement to frame the topic of the decision
- ADR provides reasonable information of viable options to decide on
  - ADR lists at least two alternative options to choose
- ADR describes what the outcome of the decision is
- ADR decision drivers are addressed by the selected decision
- ADR may describe what positive consequences result when the decision is effective
- ADR may describe what negative consequences result when the decision is effective
- ADR lists persons or groups that decided on the ADR
  - new ADR uses a placeholder like "FIXME: note the deciders" or "FIXME: deciders need to be defined"
- Ensure that the structure of the ADR contains the main topics in the following order ( see the [ADR template](./references/0000-adr-template.md) )
  - **Title**
  - Status and Date appear as bullet points directly below the title, not as a section heading
  - **Context and Problem Statement**
  - **Decision Drivers** (optional)
  - **Considered Options**
  - **Decision Outcome**
  - **Reasons for the decision** (optional)
  - **Positive Consequences** (optional)
  - **Negative Consequences** (optional)
  - **Notes** (optional)
  - **Deciders**
  - **Links** (optional)
- Optional sections must only be included when they have meaningful content — omit them entirely otherwise
- When producing an ADR from the template, do NOT copy any `<!-- optional -->` comments into the output — these annotations exist only as guidance in the template itself

### Updating or Revising an Existing ADR

The correct approach depends on the current status of the ADR being changed.

**Edit in-place** (the ADR has not yet been formally committed to):

| Status | Rationale |
|---|---|
| `draft` | Work in progress by definition — no external dependency on its content yet |
| `proposed` | Under review but not yet decided — content is still expected to change |
| `rejected` | Never put into effect — no auditable record depends on its content |

When editing in-place: update the content directly and adjust the `Date` field to today's date if the status changes. No new file is created.

**Create a new superseding ADR** (the ADR has been formally committed to):

| Status | Rationale |
|---|---|
| `accepted` | The decision is in effect and part of the auditable record — in-place edits would silently destroy traceability |
| `deprecated` | Was previously accepted; its history must remain intact |

When a new ADR supersedes an accepted or deprecated one, apply the following steps:

1. **Create the new ADR** with the next available number and status `draft`. Include a back-reference near the top of the new file:
   ```
   Supersedes [ADR-XXXX](./XXXX-original-adr-name.md).
   ```
2. **Update the original ADR**: change its status to `superseded by [ADR-YYYY](./YYYY-new-adr-name.md)` and update the `Date` field to today's date (the date the supersession takes effect). Add a forward-reference directly below the status line:
   ```
   Superseded by [ADR-YYYY](./YYYY-new-adr-name.md).
   ```
   Do not alter any other content of the original ADR — its historical record must remain intact.
3. **Consistency check**: check whether all ADRs referenced by the new ADR contain inconsistencies or contradict it.
4. Only promote the new ADR from `draft` to `accepted` on explicit instruction to do so.
5. When promoting an ADR to a terminal status (`rejected`, `accepted`, or `deprecated`) ensure that section **Deciders** has real names of persons or teams instead of "FIXME" or "TODO" placeholders. The `proposed` status does not require this check — the decision has not yet been made and deciders may not be known.

## Examples

- A template for an ADR can be found [template](./references/0000-adr-template.md)
