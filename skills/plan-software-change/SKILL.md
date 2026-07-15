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
   Invoke available domain-specific skills (e.g. architecture, security, unit-test, e2e-test,
   integration-test, database, cloud, Kubernetes, python, go, typescript, rust, react, vue asf.)
   when they would deepen the research.
3. Check input/requirements for consistency
4. Suggest improvements to the input/requirements
5. Note open questions, unclear requirements, implications for security or topics that need clarification before
   implementation and/or planning can start
6. Create a structured plan how the change can be implemented, incl. necessary changes to the tests or related documentation
7. Write the output to a sidecar file next to the user's input file. Derive the sidecar name by
   inserting `-plan` before the file extension (e.g. `#123.md` → `#123-plan.md`). Create the
   file if it does not exist; if it already exists, update it in place. When the user answers
   open questions, remove the resolved question from the "Open Questions" section, incorporate
   the answer into "Implementation Hints", and update the plan accordingly.

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
     components found in step 2. -->

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

<!-- Questions the user must answer before implementation can proceed.
     Remove a question once answered; move the answer into Implementation hints above. -->
```
