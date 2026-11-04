Carbonio amavisd (`carbonio-amavisd`) as a content filter in front of postfix, with a small configuration set through environment variables. Virus checking only: spam checks, DKIM, quarantine and notifications are off.

| Variable | Default | Meaning |
| --- | --- | --- |
| `AMAVIS_HOSTNAME` | `carbonio-mta.localdomain` | `$myhostname`, used in headers |
| `AMAVIS_DOMAIN` | `localdomain` | `$mydomain` |
| `AMAVIS_LISTEN_ADDRESS` | `127.0.0.1` | Address amavis listens on for postfix (`content_filter`) |
| `AMAVIS_LISTEN_PORT` | `10024` | Port amavis listens on |
| `AMAVIS_INET_ACL` | `127.0.0.1 [::1]` | Clients allowed to connect |
| `AMAVIS_FORWARD_HOST` | `127.0.0.1` | Where clean mail is re-injected (postfix) |
| `AMAVIS_FORWARD_PORT` | `10025` | Re-inject port |
| `AMAVIS_FINAL_VIRUS_DESTINY` | `D_REJECT` | What to do with infected mail: `D_REJECT`, `D_DISCARD`, `D_BOUNCE`, `D_PASS` |
| `AMAVIS_MAX_SERVERS` | `2` | Number of amavis child processes |
| `AMAVIS_LOG_LEVEL` | `1` | amavis log level (0-5), logged to the console |
| `CLAMD_ADDRESS` | `127.78.0.17:20000` | clamd to stream mail to: the `carbonio-mta` sidecar upstream to `carbonio-clamav`, as on a package install |
