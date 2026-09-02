---
name: plan-software-change
description: Create and update a plan to change software — to introduce new features or fix bugs.
---

# Plan Software Change

Given an input file path or provided requirements, plan the change to existing or new software.

**The sidecar plan file must be fully self-contained.** A new agent session given only that file
and access to the repository must have all the context needed to implement the change without
reading the original input file or this conversation.

**Before writing, verify the plan contains:**
- [ ] The system or component being changed
- [ ] The goal and motivation for the change
- [ ] Acceptance criteria or definition of done
- [ ] Key constraints (dependencies, contracts, shared state)
- [ ] Concrete starting point (first file to open, first test to run)
- [ ] A new agent could begin implementing without reading the original input

1. Analyze the input/requirements  
   → Output: **Context** (goal, motivation, acceptance criteria, constraints, background).
2. Research the current project  
   → Output: **Context** (dependencies, contracts) and **Implementation Hints** (grounded facts).
   - Search for related info — referenced files, configs, docs, tests, existing patterns, and
     project conventions (e.g. `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`, architecture decision
     records, coding guidelines, style guides) relevant to the change.
   - Identify existing documentation that describes the components or behavior being changed (e.g.
     README, architecture/API docs, ADRs, changelogs, user guides) so it can be tracked for updates
     in the plan.
   - If the change touches a domain with an available skill (e.g. database, cloud, security,
     language-specific), invoke that skill and fold its findings into **Implementation Hints**.
   - If research reveals requirements are infeasible, decide where to document the blocker:
     - Missing resource that could be obtained → **Open Questions**.
     - Contradiction with an existing invariant → **Consistency Issues** (prefix `[high]`).
     - Fundamentally impossible regardless of resources → note in **Context** and halt planning.
3. Create a structured plan how the change can be implemented, including necessary changes to
   tests and to existing documentation that describes the affected components  
   → Output: **Implementation Plan**.
4. Suggest improvements to the input/requirements  
   → Output: **Proposed Improvements** (optional — omit section if none).
5. Analyze the plan itself for consistency: check whether any step, as written, would introduce or
   silently rely on a contradiction  
   → Output: **Consistency Issues** (optional — omit section if none).  
   "Consistency issues" are contradictions or conflicts with existing invariants that the planned
   change would introduce or silently rely on. Prefix each entry with `[high]` if it blocks
   implementation, or `[low]` if it can be resolved during implementation. Keep them distinct
   from the "Implementation Plan" (concrete steps) and "Implementation Hints" (grounded facts)
   and non-redundant with both. See the Output Format template for what counts as a consistency issue.
6. Note open questions, unclear requirements, implications for security or topics that need
   clarification before implementation and/or planning can start  
   → Output: **Open Questions** (optional — omit section if none remain).
7. Write the output to a markdown sidecar file  
   → Output: the assembled sidecar file.  
   The sidecar must contain every section produced above, assembled in the order shown below.
   After writing, ensure the file ends with exactly one newline and no trailing blank lines or
   `---` rules.
   **Sidecar file naming:**
   - If no input file path is given, ask the user for a name to use for the sidecar output file
     before proceeding (propose a short/multi-word filename derived from the plan content with words
     delimited by "-").
   - If input file path is given, derive the sidecar name by inserting `-plan` before the
     file extension (e.g. `#123.md` → `#123-plan.md`).
   - If the input has no extension, append `-plan` to the basename (e.g. `Dockerfile` →
     `Dockerfile-plan.md`, `Makefile` → `Makefile-plan.md`).
   - If the input is a directory, ask the user for a filename.
   - Create the sidecar file if it does not exist. If it already exists, overwrite it entirely
     with the updated plan.

Produce the template sections in the order shown below. Don't duplicate content across sections.

## Resolving open questions

Whenever an open question is resolved (whether answered by the user or through agent research),
apply steps 1–3 in one update. Additionally, if after resolution no questions remain, also apply
step 4:

1. Remove the question entry from the **Open Questions** section.
2. Incorporate the answer as a concrete note in **Implementation Hints**.
3. Update any affected steps in the **Implementation Plan**.
4. Remove the **entire** **Open Questions** section, including its heading
   and all surrounding blank lines.

## Output format

Write the following Output Format template into the sidecar file (e.g. `#123-plan.md`).
Strip all HTML comments from the template when writing; they are authoring guidance only.
OMIT optional sections when they have no content.

```markdown
# Title <!-- Generate a meaningful title for the planned task -->

## Context

<!--
Everything a new agent needs to understand the task without reading the original input:
the system/component being changed, goal and motivation, key constraints, acceptance
criteria, and relevant background (related issues, shared contracts, dependencies).
Completeness matters more than brevity. Keep high-level background here; fold concrete,
codebase-derived details (exact file paths, config keys, version constraints) into
Implementation Hints rather than restating them here.
-->

## Implementation Plan

<!--
Numbered, actionable steps describing what needs to change and why, referencing
specific files and components found in step 2. Steps should be granular enough
that a new agent can execute one step without further decomposition; prefer one
step per logical change over one step per file. Include explicit steps for
updating existing documentation affected by the change (README, architecture/API docs,
ADRs, changelogs, inline doc comments, etc.), referencing the specific doc files.
A source change that leaves its documentation stale is an incomplete
change.

Add a task-list checkbox to every numbered step and its sub-steps, using the format
`1. [ ] Step text`. Note in the plan introduction that an implementing agent must
flip `[ ]` to `[x]` immediately after completing each step and rewrite the sidecar
file in place, so progress is resumable across sessions.
-->

## Proposed Improvements <!-- OPTIONAL — omit section entirely if none -->

<!--
Suggestions that go beyond the stated requirements and would improve quality, safety,
or maintainability.
-->

## Consistency Issues <!-- OPTIONAL — omit section entirely if none -->

<!--
Contradictions or conflicts with existing invariants that the planned change
would introduce or silently rely on.

Triage: action → Implementation Plan; fact/constraint → Implementation Hints;
contradiction that must be acknowledged before the plan is coherent → here.

Example: "[high] Step 3 adds a REST endpoint to module A, but ADR-0007 mandates
all new external interfaces go through module B. This contradicts the architecture
decision and must be resolved before implementation."

When nothing genuinely conflicts, OMIT the entire section.
-->

## Implementation Hints

<!--
Concrete, grounded guidance derived from codebase research (step 2) and resolved open
questions (when the answer is just information and not a task). This section must contain
facts only — never actionable steps.

- exact file paths
- config keys
- version constraints
- behavior confirmed by code reading, etc.
-->

## Open Questions <!-- OPTIONAL — omit section entirely if none remain -->

<!--
Questions that must be resolved before implementation and/or planning can start.
Follow the "Resolving open questions" protocol above when closing each one.
-->
```
