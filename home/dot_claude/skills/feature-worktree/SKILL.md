---
name: feature-worktree
description: Generic workflow for adding a new feature to any git project - creates a herdr worktree branch, delegates the work to a bounded subagent, merges the default branch into the feature branch and runs the project's tests, then merges into the default branch with a semantic version bump and tag. Use this whenever the user wants to add, implement, build or prototype a feature in a repo, even if they don't mention branches or worktrees. Skip it for small bug fixes, renames and docs-only edits unless asked.
---

# Feature worktree workflow

Isolating each feature in its own worktree keeps the default branch releasable and lets several
features run in parallel. Merging the default branch in *before* merging out catches breaking
changes on the feature branch, where they are cheap to fix.

## 0. Learn the project first

Read the project's `AGENTS.md` / `CLAUDE.md` / `CONTRIBUTING.md` and note, before doing anything:

- **Default branch** (`git symbolic-ref --short refs/remotes/origin/HEAD`, else `main`/`master`).
- **Check commands**: format, lint, type-check and test. Typical sources: `Makefile`,
  `justfile`, `package.json` scripts, `pyproject.toml` (`ruff`, `mypy`, `pytest`, `tox`, `nox`),
  `Cargo.toml` (`cargo fmt/clippy/test`), `go.mod` (`go vet/test ./...`), CI config in
  `.github/workflows/`. Prefer what CI runs.
- **Version location**: `pyproject.toml`, `package.json`, `Cargo.toml`, `VERSION`, `__version__`
  in a module, etc. Lockfiles that must follow (`Cargo.lock`, `package-lock.json`, `uv.lock`).
- **Changelog / todo files** and whether commits follow Conventional Commits.
- **Merge etiquette**: if the project says to ask before merging, ask.

If the project rules and this skill disagree, the project rules win.

## 1. Create the worktree

On an up-to-date default branch:

```sh
herdr worktree create --cwd <repo> --branch feat/<short-name> --base <default-branch> --label <short-name> --no-focus
```

Note the worktree path and workspace ID. Use kebab-case names with a `feat/` prefix.

Gitignored files a new worktree lacks but the work needs (sample data such as a `test-corpus/`
directory, local `.env` files, fixtures) must be linked in from the main checkout, e.g.
`ln -s <repo>/test-corpus <worktree>/test-corpus`. Check `.gitignore` and the project docs for
what applies.

## 2. Implement in a bounded subagent

Spawn one subagent (Agent tool, `general-purpose`) working in the worktree. Give it a
self-contained brief:

- the feature description and acceptance criteria,
- the worktree path: all edits and commands happen there, never in the main checkout,
- the conventions found in step 0 (code layout, tests required for new behaviour, docs to keep
  in sync, a changelog line under the unreleased section, remove the item from any todo file),
- scope limits: only files the feature needs, no unrelated refactors, no merging, no pushing,
  no touching the default branch,
- to commit on the feature branch using the project's commit style,
- to finish by running the format, lint and test commands and reporting what changed and the
  results.

Review its report and diff (`git -C <worktree> diff <default>...HEAD`) before continuing.

## 3. Merge the default branch into the feature branch

```sh
git -C <worktree> merge <default-branch>
```

Resolve conflicts, then run the lint and test commands in the worktree. Fix breakage on the
feature branch, not on the default branch.

## 4. Merge into the default branch

Report the passing result and ask for the go-ahead (unless the user has said to merge
automatically). Then, from the main checkout:

```sh
git merge --no-ff feat/<short-name>
<test command>
```

## 5. Bump the version and tag

Choose the semantic version bump: new feature is minor, fix-only is patch, breaking change is
major (minor while on 0.x). Do not move to 1.0.0 unless the user says so. Then:

1. Update the version where the project keeps it (step 0), and refresh the lockfile if there is
   one.
2. Move the changelog's unreleased entries under a dated `## [x.y.z] - YYYY-MM-DD` heading,
   keeping an empty unreleased section above. Skip if the project has no changelog.
3. Commit (`chore(release): vX.Y.Z` or the project's style) and tag that commit with
   `git tag -a vX.Y.Z -m "vX.Y.Z"`, matching the project's existing tag format.

State the chosen version and why. Do not push the commit or tag unless asked.

Afterwards offer to remove the worktree (`herdr worktree remove --workspace <ID>`) and delete
the feature branch.
