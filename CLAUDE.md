@AGENTS.md

## Claude Code specifics

- Project skills live in `.claude/skills/`.
- `.claude/settings.json` allows the syntax and lint checks and denies
  running `trans.sh`.
- Run `bash -n trans.sh` and `shellcheck trans.sh` before reporting a task as
  done.
