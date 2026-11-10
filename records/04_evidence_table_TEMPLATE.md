# Evidence Table (copy rows from evidence/kali/test-results.csv and add log references)
Student: Chioma Ameh | ID: C11/26/CGRCE/17567

| Test ID | Source IP | Requested service | Expected | Actual | Timestamp | Log reference |
|---|---|---|---|---|---|---|
| F1 | (Kali IP) | http://SERVER/public/ | 200 | | | nginx grc_access.log line # |
| F2 | (second IP) | http://SERVER/public/ | timeout | | | ufw-block-log.txt line # |
| L2 | (Kali IP) | /archive/ | 403 | | | grc_access.log line # |

Rule: do NOT invent log lines. If an event is missing, write "log not collected - control UNVERIFIED (not failed)" and explain.
