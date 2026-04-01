---
name: markdown-docs-review
user-invocable: true
description: >
  Audits all Markdown (*.md) documentation files in the project for consistency, duplication,
  broken links, and contradictions. Checks single-source-of-truth violations, verifies relative
  links and anchors, reconciles contradictions between files, and fixes all findings in place.
  Iterates until a full pass produces zero fixable findings.
---

# Markdown Docs Review

Perform a full consistency audit of the project documentation, fix all findings, and iterate until
the documentation is clean.

## Scope

By default this skill audits the entire repository. If the user explicitly names specific files,
directories, or glob patterns, apply the following rules for the entire run:

* **Step 1a — Find all documentation files:** Collect only files within the named scope. Apply
  the same exclusions (build dirs, `.git/`, tooling dirs, etc.) as in a full run.
* **Reading for context:** When a scoped file references, links to, or may duplicate content in
  a file outside the scope — including sidecar diagram files — read that external file on demand
  to correctly assess consistency, but do not fix it. Do not collect diagram references from
  out-of-scope files; findings inside those diagrams are out of scope. If an out-of-scope diagram
  contains a term that conflicts with a scoped file, report the finding rather than fixing either
  side.
* **Fixes:** Apply fixes only to files within the scope. When the correct fix requires editing an
  out-of-scope file (e.g. the authoritative copy of duplicated content lives outside the scope),
  report the finding instead and note which out-of-scope file is involved.
* **Orphan check:** Skip orphan detection entirely for scoped runs. A scoped file may legitimately
  be linked only from files outside the scope and is not orphaned by definition.

## File Roles

> Reference sidebar — not a procedural step. Consult during Step 1b when mapping files to roles
> and during Step 2 when deciding where information belongs.

### Role Table

Assign each file's role from its name and location using the signals below. Where name and
location are ambiguous, the catch-all row applies; content-based signals (opening section,
structured schema) are confirmed during Step 1c when the file is actually read:

| Signal | Likely role |
| ------ | ----------- |
| Named `README.md` at repo root | **Entry point** — developer orientation, prerequisites, index of other docs |
| Named `CLAUDE.md` at repo root | **AI agent context** — information exclusively useful for AI agents operating in this repo; links out to other docs rather than duplicating them |
| In a directory named `runbooks/`, `how-to/`, `guides/`, `playbooks/`, or similar | **Operational guide** — task-oriented, one topic per file |
| In a directory named `docs/`, `documentation/`, `references/`, `architecture/`, or similar (but not a runbooks subdirectory) | **Reference file** — single source of truth for a specific topic; not a step-by-step guide |
| Follows a structured schema (ADR status/context/decision fields, RFC template, CHANGELOG sections, etc.) | **Skill-governed file** — see Step 1c |
| Sidecar diagram file (`.mmd`, `.mermaid`, `.puml`, `.plantuml`, `.svg`, `.drawio`) | **Inherits the role of its referencing `.md` file.** If referenced by multiple `.md` files with different roles, use the role of the most authoritative referencing file (apply the role hierarchy: reference file > entry point > AI agent context > operational guide). |
| Anywhere else, name suggests a specific topic | Treat as a reference file until content proves otherwise |

**When multiple signals match:** skill-governed takes precedence over all other roles. A
`CHANGELOG.md` in a `docs/` directory matches both "reference file" and "skill-governed" —
treat it as skill-governed. All other signal conflicts use the catch-all row.

### Role Principles

* **Entry point files** (`README.md`) orient new readers. They should link to other files, not
  duplicate their content.
* **AI agent context files** (`CLAUDE.md`) contain information that is exclusively useful to an
  AI agent — machine-readable inventories, agent-specific rules, env var names needed for code
  generation. They should not contain general information that developers also need.
* **Reference files** are the single source of truth for a specific topic (a naming convention,
  an architecture overview, a data model). Other files should link to them, not copy from them.
* **Operational guides / runbooks** are task-oriented and procedural. They should cross-link to
  reference files for background, not embed that background inline.

### Where Does Information Belong?

When it is unclear which file should own a piece of information, apply these rules in order:

1. **Is it exclusively useful to an AI agent and not to a developer?**
   If yes → `CLAUDE.md` (or the project's equivalent agent context file). Examples:
   machine-readable resource inventories, env var names an agent needs to generate code,
   agent-specific rules with no operational meaning for humans.
   If no → continue to rule 2.

2. **What is its nature?** Place it in the most appropriate existing file:
   * Step-by-step procedure for humans → **operational guide / runbook**
   * Stable reference material (conventions, architecture, naming rules, data models) → **reference file**
   * Entry-point orientation, prerequisites, or project index → **`README.md`**
   * Anything else (glossary, decision log, meeting notes, changelog without a governing skill,
     etc.) → **reference file** in the most appropriate existing reference directory.
   If no existing file covers the topic, create a new file in the location that matches the
   project's existing documentation structure.

3. **Does the same information appear in the agent context file AND another file?**
   Remove it from the agent context file and replace with a link — unless the content is
   genuinely agent-specific (rule 1 above). General information does not belong in the agent
   context file even if an agent also needs to read it.

## Step 1 — Discover

### 1a. Find all documentation files

Use `Glob` with `**/*.md` to get the full list of markdown files in the repository, then exclude:

* Dependency and build directories: `node_modules/`, `vendor/`, `build/`, and similar generated output folders
* Generated output directories: any directory that contains committed rendered or compiled artifacts rather than authored content (e.g. `apps-rendered/`, `dist/`, `out/`)
* VCS metadata and ignored paths: `.git/`; also read `.gitignore` if present and exclude any
  directories it names — they are untracked by design and not authored documentation content
* Tooling configuration directories: `.claude/`, `.agents/` (and all their descendants), and any other hidden directories at the repo root that contain skill, agent, or tool definitions rather than project documentation

Do not assume a fixed directory structure — projects vary. Run this glob fresh on every pass.

The surviving set of `.md` files is the **working list** for this pass. It grows during Step 1c
as sidecar diagram files are discovered.

### 1b. Map each file to a role

Before checking consistency, assign a role to each file using the File Roles reference above.
Role assignment based on name and location is done here. Reading happens in Step 1c — see the
note there about reading `CLAUDE.md` before other files.

If a file's role cannot be determined from name and location alone, mark it as ambiguous —
finalize its role during Step 1c after reading its content.

If a file's name or directory suggests it follows a structured schema (e.g. files in an `adr/`
or `decisions/` directory, files named `CHANGELOG.md`), flag it as potentially skill-governed.
Complete steps 1–2 of skill-governed detection during Step 1c after reading the file.
The delegation protocol (assess scope, fix at boundary, note in report) runs in Step 3 when
each finding is processed.

### 1c. Read every file in full

If `CLAUDE.md` exists in the repository, read it before any other file — its conventions inform
role mapping for all other files. This applies even in scoped runs where `CLAUDE.md` falls
outside the scope: read it as context but do not fix it and do not add it to the working list.

In a scoped run, read other out-of-scope files on demand — only when a specific finding requires
context from a referenced external file, not speculatively upfront. When reading an out-of-scope
file, do not fix it and do not collect its diagram references (see Scope section).

Read every remaining file in the working list completely, skipping `CLAUDE.md` if it was
already read above. As you read each file, perform the following:

**Collect sidecar diagram references.** For every link or image reference whose target has a
textual diagram extension (`.mmd`, `.mermaid`, `.puml`, `.plantuml`, `.svg`, `.drawio`):
* **In a full run or if the diagram is within the scope:** add it to the working list if not
  already present. After finishing the current file, read any newly added diagram files before
  continuing. This ensures all diagram content participates in existence checks and terminology
  checks in Steps 2 and 3.
* **In a scoped run and the diagram is outside the scope:** treat it as an out-of-scope file —
  read it for context and existence checking, but do not fix it and do not collect its own
  diagram references.

Textual diagram formats and the content to extract for terminology checks:
* **Mermaid** (`.mmd`, `.mermaid`) and fenced ` ```mermaid ` blocks: node names, edge labels, annotations
* **PlantUML** (`.puml`, `.plantuml`) and fenced ` ```plantuml ` blocks: element names, labels, notes
* **SVG** (`.svg`): `<text>`, `<title>`, `<desc>`, aria labels
* **draw.io** (`.drawio`): cell labels and tooltip attributes in the XML

**Fenced script blocks** (` ```bash `, ` ```sh `, ` ```zsh `, ` ```shell `, ` ```powershell `,
` ```fish `) contain executable commands. Note their contents for contradiction checks in Step 2
— commands and tool invocations must not contradict documented procedures or tooling choices.
Do not apply terminology drift checks to their contents.

**Fenced data/config blocks** (` ```yaml `, ` ```json `, ` ```toml `, ` ```xml `, ` ```csv `)
and all other non-diagram, non-script language tags are not documentation content. Skip them
entirely.

**Handle malformed diagram files.** If a sidecar diagram file exists but its content cannot be
parsed (e.g. malformed XML in a `.drawio` or `.svg` file), report it as a finding per the
report-only path in Step 3. Do not attempt to fix its content or extract terminology from it.

**Handle binary image references.** For every link or image reference whose target is a binary
image file (`.png`, `.jpg`, `.jpeg`, `.gif`), note its path for the existence check in Step 2.
Do not read binary image content.

**Handle unknown or missing extensions.** If a referenced file has no extension or an
unrecognized extension, treat it as binary: note its path for an existence check only.

**Check front matter.** If a file contains YAML front matter or metadata comments — including
sidecar diagram files that carry such metadata — treat those fields (`name`, `description`,
`type`, etc.) as content subject to consistency checks. Verify they are not stale or mismatched
relative to the file's actual content.

**Complete skill-governed detection.** For any file flagged as potentially skill-governed in
Step 1b, or any file whose content reveals a structured schema upon reading:

1. **Identify the format** — look for telltale structural markers: numbered status fields
   (`Status: Accepted`), fixed section headings (`## Context`, `## Decision`, `## Consequences`),
   or a machine-readable front matter block.
2. **Check for an owning skill** — look in `.claude/skills/` and `.agents/` for a skill whose
   name or description matches the detected format (e.g. `architecture-decision-record`).
   These directories are excluded from the documentation audit in Step 1a, but you must still
   read them here to identify whether an owning skill exists.

Record the owning skill (if found) against the file. Delegation of findings to the owning skill
happens in Step 3 when each finding is processed.

## Step 2 — Check for Inconsistencies

Check across all files for the following patterns. When deciding where information belongs, apply
the "Where Does Information Belong?" rules in the File Roles section above.

### Duplication (single-source-of-truth violations)

* The same table, list, or paragraph appears in two or more files.
* A file re-states a fact (e.g. a naming rule, a URL pattern, a version number) that is already
  the authoritative responsibility of another file.
* An index or table of other documents appears in more than one place.

**Fix:** Keep the information in the most authoritative file. Replace the duplicate with a
markdown link: `See [filename.md](relative/path/to/filename.md) for …` Route the fix through
Step 3: a short self-contained duplicate (a single sentence, a single bullet, or a brief
definition) is a silent fix; anything larger or structural (a section, a table, a multi-step
procedure) is a structural fix.

### Broken or Incorrect Links

* A relative link target does not exist (wrong path, wrong anchor, file renamed). This applies
  to all referenced file types collected in Step 1c: `.md` files, sidecar diagram files, and
  binary image files.
* A relative path is calculated from the wrong base directory
  (e.g. a link in `docs/runbooks/foo.md` must use `../` to reach `docs/bar.md`).
* An anchor `#section-name` does not match any heading in the target file.
* A referenced sidecar diagram file exists but is malformed and cannot be parsed (e.g. invalid
  XML in a `.drawio` or `.svg` file).
* An absolute URL (`https://...`) that is an obvious placeholder (e.g. `https://example.com`)
  or is explicitly noted as broken or moved in another file. Do not speculatively check live
  external URLs — flag only what can be determined from the documentation itself.

**Fix:** Correct relative path and anchor issues. Verify by tracing from the file's directory.
Malformed diagram files and absolute URL issues are report-only — do not attempt to fix them.

### Contradictions Between Files

* A rule stated in one file contradicts documented reality in another file (e.g. a rule says
  "always X" but a table elsewhere lists known exceptions to X).
* A naming convention or pattern described in one place uses different placeholder names
  elsewhere, causing ambiguity or accidental double-application of a suffix or prefix.
* A command or tool invocation in a fenced script block contradicts documented procedures or
  tooling choices in another file (e.g. a script block uses `yarn` when the docs mandate `npm`,
  or shows a deprecated command that another file explicitly replaces).
* A version number pinned in a script block or prose contradicts a version stated elsewhere.

**Fix:** Route through Step 3 based on scope:
* Updating command(s) in a script block to match documented procedure → silent fix.
* Reconciling a contradicted rule across prose files (updating the rule or adding a qualifying
  sentence explaining a known exception with a migration plan) → structural fix.
* Version contradictions → report only. Do not auto-fix: the pinned version may be intentional
  and the correct resolution requires the author's judgment.

**Note:** Do not cross-check documentation against application source code — that is out of scope
for this skill. Only compare documentation files against each other.

### Wrong Audience / Misplaced Content

* The agent context file contains prose instructions or commands written for human developers
  that have no operational meaning for an agent.
* The entry-point file contains agent-specific rules or machine-readable inventories that belong
  in the agent context file.
* A reference file contains step-by-step procedural content that belongs in an operational guide.
* An operational guide embeds reference material (conventions, architecture background) inline
  instead of linking to the reference file that owns it.

**Fix:** Move the content to the correct file and replace the moved block with a link.
This is always a structural fix — announce before applying.

### Terminology Drift

* The same concept is referred to by different names across files.
* Placeholder conventions differ across files (e.g. UPPER-CASE in one file, `<angle-bracket>`
  in another).
* Node names, edge labels, and annotations inside fenced diagram blocks or sidecar diagram files
  use different terms for the same concept than the surrounding prose or other documentation files.

**Fix:** Pick the canonical term used by the most authoritative file and update all others to
match, including diagram labels and annotations. Updating terms in-place is a silent fix.
If fixing terminology requires moving or restructuring content, use the structural fix path.

### Orphaned Files

* A file exists but is never linked to from any other documentation file — it is unreachable
  unless a reader knows its path directly.

**Exempt from this check:** The following are never flagged as orphaned:
* `README.md` and `CLAUDE.md` at the repo root — reachable by convention.
* Sidecar diagram files:
  * In a full run: they were added to the working list via a `.md` reference — that reference
    is their inbound link.
  * In a scoped run where the diagram is outside the scope: they are never added to the working
    list and therefore cannot appear as orphans.

**Fix:** Do not auto-fix. Report the orphaned file per the report-only path in Step 3.

## Step 3 — Report and Fix

For every finding, state the affected file(s) and line reference (where applicable — file-level
findings such as orphaned files or malformed diagrams have no specific line) and describe the
issue (duplication / broken link / contradiction / misplacement / terminology / orphan), then
act according to one of the four paths below.

If a finding matches more than one category, apply the fix path that resolves the most issues
in a single action: structural always beats silent; among structural fixes, prefer the action
that eliminates the most violations (e.g. moving misplaced content resolves both misplacement
and duplication at once).

Before routing, check whether the finding affects a skill-governed file identified in Step 1c.
If so, use the delegated findings path first.

### Delegated findings — invoke the owning skill

When a finding falls within the scope of a skill-governed file's owning skill:

* **Assess scope** — read the owning skill's `SKILL.md` to confirm the finding (e.g. a missing
  required section, a malformed status field, an outdated superseded-by reference) is within what
  that skill is designed to handle. If yes, delegate rather than fix directly.
* **Only fix what falls outside the owning skill's scope** — a broken markdown link *pointing to*
  a skill-governed file from a regular doc is yours to fix; a corrupted ADR status field is not.
* **Note each delegation in your report** — record which skill was invoked and what the finding
  was, so the user has a complete picture.

### Report-only findings — no edit

State the file, the issue, and the user's options. Do not make any edit.

* Orphaned files (see Step 2 — the user decides whether to add a link, merge, or delete).
* Version contradictions (see Step 2 — Contradictions) — the pinned version may be intentional.
* Malformed diagram files (see Step 2 — Broken or Incorrect Links) — file exists but cannot be
  parsed; content fix requires the author.
* Absolute URL issues (see Step 2 — Broken or Incorrect Links) — cannot be resolved without
  network access or author knowledge.
* Any finding where the correct resolution requires a judgment call that cannot be made without
  business context (e.g. two files with equal claim to owning the same information).

### Silent fixes — apply without announcing

State the file, line (where applicable), and issue, then apply immediately:
* Correcting a broken or incorrect link path or anchor.
* Normalizing terminology to match the canonical term.
* Removing a duplicated passage and replacing it with a link, per the threshold defined in
  Step 2 — Duplication. If the passage is structural, use the structural fix path instead.

### Structural fixes — announce, then apply in the same response

State what you are about to do, then apply immediately — do not wait for the user to reply,
but make the action visible:
* Moving a section from one file to another.
* Creating a new file (e.g. extracting duplicated content into a new runbook or reference file).
* Deleting a section entirely (rather than replacing it with a link).
* Any change where it is not obvious which file should be authoritative.

Update all linking files in the same pass as the fix.

## Step 4 — Restart

After completing a full pass and applying all fixes, **restart from Step 1**. Re-read all files
from disk (do not rely on memory of the previous read — edits may have introduced new issues).
Repeat until a complete pass produces zero **fixable** findings.

**Suppressing duplicate reports:** Track all report-only findings already reported (orphaned
files, version contradictions, malformed diagrams, absolute URL issues). On passes 2 and beyond,
do not re-report a finding that was already reported in a prior pass — unless it is newly
introduced as a side effect of edits made in the previous pass (e.g. the only inbound link to a
file was replaced, making it newly orphaned).

**Delegated findings across passes:** Do not suppress delegated findings — re-delegate on each
pass if the finding still exists. If a delegated finding persists after the owning skill has been
invoked on three separate passes without resolving it, stop delegating and escalate to the user
as a report-only finding with a note that delegation did not resolve it.

**Termination guard:** If pass 4 still finds fixable issues, stop iterating. Report the remaining
findings to the user with a note that they require human judgment to resolve — this signals a
structural conflict (e.g. two files that each have a legitimate claim to owning the same
information) that the skill cannot resolve unambiguously on its own.

After every pass (including the terminal one), output a single summary line:

> **Pass N — X fixed, Y reported for user action, across Z files.**
> (Z = number of distinct files that had at least one finding, including sidecar diagram files.
> Use "0 fixed" for a clean pass; omit "reported" if there are none.)

A pass with 0 fixable findings is the signal to stop.

## Constraints

### MUST DO
* Read every file from disk on every pass — never rely on a cached version.
* Apply fixes per the four paths in Step 3 — do not batch to a separate step.
* Prefer linking to moving: if information already lives in the right place, link rather than
  copy.
* Verify relative link paths by tracing from the file's directory, not the repo root.
* After every fix, check whether the fix itself introduced a new inconsistency.

### MUST NOT DO
* Do not add content to a file that does not belong there just to make it "more complete".
* Do not create a new file unless the content genuinely has no correct home in an existing file.
* Do not read or check the content of binary image files (`.png`, `.jpg`, `.jpeg`, `.gif`) or
  files with unknown extensions — only verify they exist at the linked path.
