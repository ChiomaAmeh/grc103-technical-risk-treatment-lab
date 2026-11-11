# Evidence Table - Chioma Ameh | C11/26/CGRCE/17567

All rows are taken from the real outputs captured in this lab (Kali `test-results.csv`, Ubuntu Nginx and kernel logs).
Kali timestamps are UTC+01:00 (WAT). Ubuntu logs are in Ubuntu's own clock (UTC), which is **not synchronised**
(NAT disconnected, no NTP). The offset was measured for each test and is shown below; it is not constant.

## Treatment and validation tests
| Test | Source IP | Requested service | Expected | Actual | Kali timestamp | Ubuntu log reference (Ubuntu clock) | Offset (Kali UTC − Ubuntu) |
|---|---|---|---|---|---|---|---|
| B1 | 192.168.56.101 | http://192.168.56.20/ | 200 (listing) | 200 | 2026-11-09T12:48:34+01:00 | not in the log extract (before 12:52) | n/a |
| B2 | 192.168.56.101 | /archive/dummy-records.txt | 200 | 200 | 2026-11-09T12:48:34+01:00 | not in the log extract | n/a |
| B3 | 192.168.56.101 | :8080/ (legacy) | 200 | 200 | 2026-11-09T12:48:34+01:00 | Python server, no Nginx log | n/a |
| A1 | 192.168.56.101 | :8080/ (legacy) | refused | no response | 2026-11-09T12:55:14+01:00 | none (service retired) | n/a |
| A2 (re-run) | 192.168.56.101 | /public/ | 200 | 200 | 2026-11-09T14:03:16+01:00 | grc_access.log `[09/Nov/2026:12:52:11]` GET /public/ 200 | 11 min 05 s |
| P1 | 192.168.56.101 | /public/ | 200 | 200 | 2026-11-09T15:10:32+01:00 | `[14:02:48]` GET /public/ 200 | 7 min 44 s |
| P2 | 192.168.56.101 | / | 403 | 403 | 2026-11-09T15:10:32+01:00 | `[14:02:48]` GET / 403 | 7 min 44 s |
| P3 | 192.168.56.101 | /archive/ | 403 | 403 | 2026-11-09T15:10:32+01:00 | `[14:02:48]` GET /archive/ 403 | 7 min 44 s |
| P4 | 192.168.56.101 | /archive/dummy-records.txt | 403 | 403 | 2026-11-09T15:10:32+01:00 | `[14:02:48]` GET /archive/dummy-records.txt 403 | 7 min 44 s |
| F1 | 192.168.56.101 (approved) | /public/ | 200 | 200 | 2026-11-09T15:59:46+01:00 | `[14:54:30]` GET /public/ 200 | 5 min 16 s |
| F2 | 192.168.56.30 (unapproved) | /public/ | timeout | no response | 2026-11-09T16:22:51+01:00 | kernel log `[UFW BLOCK] SRC=192.168.56.30 ... DPT=80 SYN`, Nov 09 15:18:44, 45, 47, 48, 49 (full log, screenshot 15c) | 4 min 07 s |
| F3 | 192.168.56.30 (unapproved) | /public/ | timeout | no response | 2026-11-09T16:22:59+01:00 | kernel log `[UFW BLOCK] SRC=192.168.56.30 ... DPT=80 SYN`, Nov 09 15:18:53–57 | 4 min 06 s |
| L1 (run 1) | 192.168.56.101 | /public/ | 200 | 200 | 2026-11-10T08:53:17+01:00 | `[09/Nov/2026:23:07:24]` GET /public/ 200 | 8 h 45 min 53 s |
| L2 (run 1) | 192.168.56.101 | /archive/ | 403 | 403 | 2026-11-10T08:53:19+01:00 | `[09/Nov/2026:23:07:26]` GET /archive/ 403 | 8 h 45 min 53 s |
| L1 (run 2) | 192.168.56.101 | /public/ | 200 | 200 | 2026-11-10T09:25:26+01:00 | `[09/Nov/2026:23:28:24]` GET /public/ 200 | 8 h 57 min 02 s |
| L2 (run 2) | 192.168.56.101 | /archive/ | 403 | 403 | 2026-11-10T09:25:28+01:00 | `[09/Nov/2026:23:28:26]` GET /archive/ 403 | 8 h 57 min 02 s |
| R1 | 192.168.56.101 | /public/ after deleting index.html | NOT 200 | 403 | 2026-11-10T09:49:00+01:00 | server Date header `23:53:10 GMT` (Nov 9) | 8 h 55 min 50 s |
| R2 | 192.168.56.101 | /public/ after restore | 200 | 200 | 2026-11-10T09:57:41+01:00 | server Date header `00:02:17 GMT` (Nov 10) | 8 h 55 min 24 s |

## Backup and recovery (measured on Ubuntu)
| Item | Value |
|---|---|
| Backup file | /srv/grc-backups/public-before-test.tgz (177 bytes, root-only directory), created 2026-11-09 23:52 (Ubuntu clock) |
| SHA-256 before deletion | e5b34d9b4fa6452b6b1d292b0ced654c99977f7ebece28a2731f633f53a50f72 (/var/www/grc-lab/public/index.html) |
| Deletion / start | 2026-11-09T23:52:22+00:00 (Ubuntu clock) |
| Portal while file missing | HTTP 403 (R1) |
| Restore end | 2026-11-10T00:00:33+00:00 (Ubuntu clock) |
| Hash verification | `sha256sum -c` = **OK** (restored file identical) |
| Observed recovery time | **490 seconds**, measured from deletion to completed restore + hash check. It includes the Kali detection check and a mistyped command, so it overstates a scripted restore. |

## Interpretation
- Approved source 192.168.56.101 reaches the portal (200) and receives 403 for the protected archive; those requests appear in the Nginx access log.
- The unapproved source 192.168.56.30 timed out. The kernel log shows `UFW BLOCK` for that address on port 80 (TCP SYN only, handshake never completed). **No Nginx log line exists for 192.168.56.30**, because the firewall dropped the packets before they reached Nginx.
- Log lines were matched by source address, request sequence and spacing (L1 → L2 are 2 seconds apart on both machines in both runs), supported by the measured clock offset.

## Clock limitation (stated honestly)
Ubuntu's clock is unsynchronised and drifted: the offset was ~4–15 minutes during the working session on 9 Nov and ~8 h 46 min–8 h 57 min on 10 Nov, because the VM was paused/suspended overnight and its clock stopped. The offset was therefore measured separately for each test group; correlation does not rely on absolute time.
