# Architecture

## Variables (`trans.sh`)

| Variable | Value in repo | Purpose |
| --- | --- | --- |
| `HOSTSERVER` | `("litest:/home/test")` | Array of `scp` targets `<host>:<path>` |
| `FILES` | `find "/home/test" -type f` | Local files, evaluated once at start |

Log files: `/var/log/<host>.txt` (needs write permission on `/var/log`).

## Functions

| Function | Behaviour |
| --- | --- |
| `main` | For each target: `pingfunction`; if reachable, `trans` for every file in `FILES`; sets `RETURN=OK` when a transfer returns `true`; then calls `submain` |
| `submain` | Calls `deletefile OK` when `RETURN` is `OK` (bash dynamic scope: sees `main`'s local), else prints an error |
| `trans` | `scp "$1" "$TRANSHOST"`; on success logs and stops; on failure logs, `sleep 5m`, retries up to 9 more times; echoes `true`/`false` per attempt |
| `pingfunction` | `ping -c 1 -W 1`; logs and echoes `true`/`false` |
| `deletefile` | With `OK`: `rm` every file in `FILES`, logs to `/var/log/$IP.txt` |

## Known issues (not fixed)

- `transfer=$(trans ...)` captures every attempt's output; after one failed
  attempt the value is multi-line and never equals `true`.
- `RETURN=OK` is set if any single file was transferred, but `deletefile`
  removes all files in `FILES`, including ones whose transfer failed.
- `for ITEM in $FILES` splits on whitespace; file names with spaces break.
- With several targets, deletion runs after the last target only and uses the
  last `IP` for its log file.
- `shellcheck` reports SC2181 (exit code checked via `$?`).
