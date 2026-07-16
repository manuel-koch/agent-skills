---
name: plan-software-change
description: Create and update a plan to change software to introduce new features, fix bugs or research a topic.
---

# Plan Software Change

Use a user given file path or the provided information to plan implementing change to existing
software or create new software. If no file path is given, ask the user for a name to use for
the sidecar output file before proceeding.

**The sidecar plan file must be fully self-contained.** A new agent session given only that file
and access to the repository must have all the context needed to implement the change without
reading the original input file or this conversation.

1. Analyze the input/requirements
2. Search for related info in current project — look for referenced files, configs, docs, tests,
   existing patterns, and project conventions (e.g. `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`,
   architecture decision records, coding guidelines, style guides) that are relevant to the change.
   Do not rely on the user input alone; actively read the codebase to ground the plan in reality.
   Identify existing documentation that describes the components or behavior being changed (e.g.
   README, architecture/API docs, ADRs, changelogs, user guides) so it can be tracked for updates
   in the plan.
   Invoke available domain-specific skills (e.g. architecture, security, unit-test, e2e-test,
   integration-test, database, cloud, Kubernetes, python, go, typescript, rust, react, vue asf.)
   when they would deepen the research.
3. Check input/requirements for consistency
4. Suggest improvements to the input/requirements
5. Note open questions, unclear requirements, implications for security or topics that need clarification before
   implementation and/or planning can start
6. Create a structured plan how the change can be implemented, including necessary changes to tests
   and to existing documentation that describes the affected components
7. Write the output to a sidecar file next to the user's input file. Derive the sidecar name by
   inserting `-plan` before the file extension (e.g. `#123.md` → `#123-plan.md`). Create the
   file if it does not exist; if it already exists, update it in place.

## Resolving open questions

Whenever an open question is resolved — whether answered by the user or through agent research —
apply **all** of the following in one update:

1. Remove the question entry from the `❓ Open Questions` section.
2. Incorporate the answer as a concrete note in `🔧 Implementation hints`.
3. Update any affected steps in the `🧭 Implementation Plan`.
4. If no questions remain, remove the **entire** `❓ Open Questions` section, including its
   heading and all surrounding blank lines.
5. After every update, ensure the file ends with exactly one newline and contains no trailing
   blank lines or horizontal rules (`---`) after the last content line.

## Output format

Write the following template into the sidecar file (e.g. `#123-plan.md`).
Omit optional sections when they have no content.

```markdown
# Title <!-- Generate a meaningful title for the planned task -->

## 📋 Context

<!-- Everything a new agent needs to understand the task without reading the original input:
     system/component being changed, goal and motivation, key constraints, acceptance criteria,
     relevant background (e.g. related issues, shared contracts, dependencies on other systems).
     Be as detailed as necessary — completeness is more important than brevity here. -->

## 🧭 Implementation Plan

<!-- Numbered steps describing what needs to change and why, referencing specific files and
     components found in step 2. Include explicit steps for updating existing documentation
     affected by the change (README, architecture/API docs, ADRs, changelogs, inline doc comments,
     etc.), referencing the specific doc files — a source change that leaves its documentation
     stale is an incomplete change. -->

## 💡 Proposed improvements <!-- OPTIONAL — omit section entirely if none -->

<!-- Suggestions that go beyond the stated requirements and would improve quality, safety,
     or maintainability. -->

## ⚠️ Consistency issues to fix <!-- OPTIONAL — omit section entirely if none -->

<!-- Contradictions, naming inconsistencies, or outdated documentation found between the
     requirements and the current codebase. -->

## 🔧 Implementation hints

<!-- Concrete, grounded guidance derived from codebase research (step 2) and resolved open
     questions: exact file paths, config keys, version constraints, behavior confirmed by
     code reading, etc. -->

## ❓ Open Questions <!-- OPTIONAL — omit section entirely if none remain -->

<!-- Questions that must be resolved before implementation can proceed.
     Follow the "Resolving open questions" protocol above when closing each one. -->
```
