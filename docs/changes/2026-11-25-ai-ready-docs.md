---
date: 2026-11-25
type: docs
scope: docs, agent tooling
files: [AGENTS.md, CLAUDE.md, .claude/settings.json, .claude/skills/document-change/SKILL.md, docs/README.md, docs/architecture.md, docs/changes/2026-11-25-ai-ready-docs.md, README.md]
breaking: false
---
# Agent-ready documentation and project skills

## Context

- The repository had only a German `README.md` and no instructions for AI
  coding agents.
- The script deletes local files, so agents need explicit rules before
  touching it.

## Change

- `AGENTS.md`: summary, read order, commands, definition of done, hard rules,
  language table, skill list.
- `CLAUDE.md`: imports `AGENTS.md` via `@AGENTS.md`.
- `.claude/settings.json`: allows `bash -n trans.sh`, `shellcheck trans.sh`,
  `make help|info|check-git`; asks before `make setup|all|clean|set-git-local|install-hooks`
  and `git push`; denies running `trans.sh` and reading `.env`.
- `.claude/skills/document-change/SKILL.md`: change record template.
- `docs/README.md`: index; `docs/architecture.md`: variables, functions,
  known issues.
- `README.md`: "Dokumentation" section.

## Decisions

- Short docs sized to one script; only the `document-change` skill.
- Known bugs are documented, not fixed (docs-only change).

## Usage / Verification

```bash
python3 -m json.tool .claude/settings.json
bash -n trans.sh
shellcheck trans.sh
```

## Follow-ups

- Missing standard files: `.editorconfig`, `CHANGELOG.md`, `CONTRIBUTING.md`,
  `.pre-commit-config.yaml`, `README.de.md` (the existing `README.md` is
  German; an English `README.md` is missing), `.gitignore`; `Makefile` has no
  build/test/tag targets. `LICENSE` exists as `LICENSE.md`.
- Data-loss risk: `deletefile` removes all files once any transfer succeeded
  (see `docs/architecture.md` "Known issues").
- `trans` output capture breaks the success check after a retry.
- `Makefile` `info` target prints emojis.
