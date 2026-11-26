# AGENTS.md

Instructions for AI coding agents working in this repository. Tool-agnostic;
`CLAUDE.md` imports this file.

## Project

`trans.sh`: Bash script that copies every file below a local directory to one
or more target hosts with `scp`, logs to `/var/log/<host>.txt`, and deletes the
local files afterwards. Plus a repository setup `Makefile` and a German
`README.md`. License GPL-3.0 (`LICENSE.md`).

The script deletes local files. Treat every change to the transfer or delete
logic as data-loss relevant.

## Read first

| Area | Doc |
| --- | --- |
| Index | `docs/README.md` |
| Script flow, functions, variables, known issues | `docs/architecture.md` |
| User documentation (German) | `README.md` |

## Commands

| Command | Effect |
| --- | --- |
| `bash -n trans.sh` | Syntax check |
| `shellcheck trans.sh` | Lint (if installed; not configured in the repository) |
| `make help`, `make info`, `make check-git` | Read-only setup helpers |
| `make setup`, `make clean`, `make set-git-local` | Write or delete setup files / change git config |

Never run `trans.sh` itself: it transfers and then deletes files.

## Definition of done

- `bash -n trans.sh` passes; `shellcheck trans.sh` shows no new findings.
- `README.md` and `docs/architecture.md` describe the current behaviour.
- New file `docs/changes/YYYY-MM-DD-<slug>.md` (template in
  `.claude/skills/document-change/SKILL.md`), listed in `docs/README.md`.

## Hard rules

- Local files may only be deleted after their transfer succeeded.
- Do not run `trans.sh`, `make setup`, `make clean` or `make set-git-local`
  unless the user asks.
- No credentials in the script; `scp` relies on the caller's ssh setup.
- No emojis in code, logs or docs.

## Language

| Artifact | Language |
| --- | --- |
| Code comments, `docs/`, `AGENTS.md`, commit messages | English |
| `README.md`, existing log messages, `Makefile` messages | German |

## Project skills

| Skill | Use for |
| --- | --- |
| `document-change` | Writing the `docs/changes/` record |
