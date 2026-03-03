---
name: architecture-decision-record
description: Write and maintain Architecture Decision Records (ADRs) following best practices for technical decision documentation. Use when documenting significant technical decisions, reviewing past architect...
---

# Architecture Decision Record (ADR)

## Instructions

- Use **Architecture Decision Record** to document decisions made for the project
- ADR is written in markdown
- ADR filename uses dash pattern `<4_digit_number>-<dash-slug-adr-title>.md`
- new ADR filenames use a numerical number, greater than any existing ADR in current folder
- ADR can be placed in a topic related subfolder under project directory `/docs/decisions/<topic-sub-folder>`
- For details of ADR see [MADR similar decision record](https://github.com/adr/madr/blob/4.0.0/docs/decisions/0000-use-markdown-architectural-decision-records.md).
- ADR has a title
- ADR has a status and a date when that status was decided
- existing ADR can be superseding / updated by a new ADR if the original decision is revised or changed. Both new and old ADR will contain links to each other and a short description why ADR was updated.
- ADR has a context and a problem statement to frame the topic of the decision
- ADR provides reasonable information of viable options to decide on
- ADR describes what the outcome of the decision is
- ADR describes what positive consequences result when the decision is effective
- ADR describes what negative consequences result when the decision is effective
- ADR lists persons or groups that decided on the ADR
- Ensure that the structure of the ADR contains the main topics in the following order
  - **Title**
  - Status and Date appear as bullet points directly below the title, not as a section heading
  - **Context and Problem Statement**
  - **Decision Drivers** (optional)
  - **Considered Options**
  - **Decision Outcome**
  - **Reasons for the decision** (optional)
  - **Positive Consequences** (optional)
  - **Negative Consequences** (optional)
  - **Deciders**
  - **Links** (optional)
- Optional sections must only be included when they have meaningful content — omit them entirely otherwise
- When producing an ADR from the template, do NOT copy any `<!-- optional -->` comments into the output — these annotations exist only as guidance in the template itself

## Examples

- A template for an ADR can be found [template](./references/0000-adr-template.md)
