---
status: <STATUS>            <!-- possible values = (draft | proposed | rejected | accepted | deprecated | superseded by ADR-XXXX ), this is just the status, superseded link will be added to the content of the ADR right below the title, "draft" and "proposed" are WIP states -->
date: <YEAR>-<MONTH>-<DAY>  <!-- date of status change -->
decision-makers: to be defined  <!-- for WIP statuses (draft, proposed): "to be defined" is the recommended placeholder, or leave empty — both are acceptable; for terminal statuses (rejected, accepted, deprecated, superseded): must contain real names of persons or teams -->
consulted:                  <!-- VALID: a key present with no value (empty) is correct when nobody was consulted — do NOT flag an empty value as a missing key; only flag when the key itself is absent from the front-matter. This key MUST always be present in the front-matter, even when empty. -->
informed:                   <!-- VALID: a key present with no value (empty) is correct when nobody was informed — do NOT flag an empty value as a missing key; only flag when the key itself is absent from the front-matter. This key MUST always be present in the front-matter, even when empty. -->
---

# A markdown ADR template          <!-- The title of the ADR, will be used in lowercase-dash-pattern for the filename too -->

<!--
Include the applicable line(s) — an ADR in the middle of a supersession chain
may include both; omit all lines if this ADR has no supersession relationship.
-->
Superseded by [ADR-XXXX](./xxxx-superseding-adr-name.md).  <!-- Use when this ADR was superseded by a newer one -->
Supersedes [ADR-XXXX](./xxxx-superseded-adr-name.md).      <!-- Use when this ADR supersedes an older one -->

## Context and Problem Statement

<!-- Describe the context and the problem that needs to be decided on. -->

## Decision Drivers <!-- optional -->

<!--
Bullets below are examples — replace with real drivers,
or omit this entire section if none.
-->
* e.g. performance or scalability requirement
* e.g. financial or regulatory requirement
* ...

## Considered Options

<!--
Option names below are examples — replace them with the real option names for this ADR.
-->
* Do foo bar on weekdays
* Do it on a daily basis

## Decision Outcome

<!--
"Do foo bar on weekdays" below is an example — replace with the actual
chosen option name, verbatim from Considered Options.
-->
Chosen option: **Do foo bar on weekdays**

<!-- Optionally list arguments that lead to the decision. -->

## Consequences

<!--
List consequences as "Good/Neutral/Bad, because ..." bullet points — include only
the types that apply; not all three are required. Bullets below are structural
starters, do NOT copy them; complete each "because" with a real consequence.
-->
* Good, because ...
* Neutral, because ...
* Bad, because ...

## Confirmation

<!--
Describe observable effects that confirm the decision is working;
include tool commands, live action observations or metrics where applicable.
Bullet below is a placeholder, do NOT copy it; write real confirmation criteria.
-->
* ...

## Pros and Cons of the Options

<!--
All Good/Neutral/Bad bullet points belong inside the named option sub-headings below.
Do NOT place bullets before the first sub-heading!
Include only the types that apply per option; not all (Good/Neutral/Bad) are required for every option.
Each option sub-heading may optionally include a short description before its bullets.
-->

### Do foo bar on weekdays <!-- example heading — replace with the actual option name from Considered Options -->

<!--
Provide a short description, example, or reference for this option —
bullets below are examples, do NOT copy them; replace {argument x} stubs
with real arguments.
-->
* Good, because {argument a}
* Neutral, because {argument b}
* Bad, because {argument c}

### Do it on a daily basis <!-- example heading — replace with the actual option name from Considered Options -->

<!--
Provide a short description, example, or reference for this option —
bullets below are examples, do NOT copy them; replace {argument x} stubs
with real arguments.
-->
* Good, because {argument d}
* Neutral, because {argument e}
* Bad, because {argument f}

## More Information <!-- optional -->

<!-- Add additional context, diagrams, or supplementary information here. -->

## Links <!-- optional -->

<!--
Add further external or internal links here — entries below are examples,
do NOT copy them; replace with real links or omit this entire section if none.
-->
* [foo](https://hello.world.com)
* ...
