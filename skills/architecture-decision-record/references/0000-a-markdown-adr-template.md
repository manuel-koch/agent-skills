---
status: <STATUS>            <!-- possible values = (draft | proposed | rejected | accepted | deprecated | superseded by ADR-XXXX ), this is just the status, superseded link will be added to the content of the ADR right below the title, "draft" and "proposed" are WIP states -->
date: <YEAR>-<MONTH>-<DAY>  <!-- date of status change -->
decision-makers: to be defined  <!-- may be empty if not decided yet, otherwise correct person/group name here if the current status mandates a valid value, for ADR in WIP status you may use "to be defined" as a placeholder -->
consulted:                  <!-- may be empty if nobody was consulted, otherwise correct person/group name here if the current status mandates a valid value -->
informed:                   <!-- may be empty if nobody was informed, otherwise correct person/group name here if the current status mandates a valid value -->
---

# A markdown ADR template          <!-- the title of the ADR, will be used in lowercase-dash-pattern for the filename too -->

<!-- optional: only include ONE of the lines below depending on the ADR's supersession role — omit both otherwise -->
Superseded by [ADR-XXXX](./xxxx-superseding-adr-name.md).  <!-- use when this ADR was superseded by a newer one -->
Supersedes [ADR-XXXX](./xxxx-superseded-adr-name.md).      <!-- use when this ADR supersedes an older one -->

## Context and Problem Statement

<!-- describe the context and the problem that needs to be decided on -->

## Decision Drivers <!-- optional -->

* e.g. performance or scalability requirement
* e.g. financial or regulatory requirement
* ...

## Considered Options

* Do foo bar on weekdays
* Do it on a daily basis

## Decision Outcome

Chosen option: **Do foo bar on weekdays**

<!-- optionally list arguments that lead to the decision -->

## Consequences

<!-- list the consequences of the decision using Good/Bad, because bullet points -->
* Good, because
* Bad, because

## Confirmation

<!-- describe observable effects that confirm the decision is working; include tool commands or metrics where applicable -->
* ...

## Pros and Cons of the Options

<!-- optionally use a bullet list to list the pros/cons of the options. Use prose sub-headings if more space is needed to describe the pros/cons of the individual options -->
* Good, because
* Neutral, because
* Bad, because

### Do foo bar on weekdays <!-- optional -->

<!-- provide more verbose information about this option; may include good, neutral or bad effects -->

### Do it on a daily basis <!-- optional -->

<!-- provide more verbose information about this option; may include good, neutral or bad effects -->

## More Information <!-- optional -->

<!-- add additional context, diagrams, or supplementary information here -->

## Links <!-- optional -->

<!-- add further external or internal links here -->
* [foo](https://hello.world.com)
* ...
