# Change and Rollback Records (all approvals SIMULATED)
Student: Chioma Ameh | Reg. No. C11/26/CGRCE/17567
Times are Ubuntu's own clock (UTC), which is unsynchronised; see records/04_evidence_table.md for offsets.

| Field | CHG-01 Retire legacy service | CHG-02 Archive protection | CHG-03 UFW source restriction | CHG-04 Backup/restore exercise |
|---|---|---|---|---|
| Change | Disable grc-legacy (:8080) | Move archive to /srv/grc-private; autoindex off; deny /archive/ | Default deny incoming; allow 192.168.56.101 to tcp/80 | tar backup + SHA-256; delete; restore |
| Business impact | None; endpoint unused | None for /public/; old URLs return 403 | Only the approved client reaches the portal | Short intentional outage (lab) |
| Approver (simulated) | IT Operations Manager | Data Owner | Security Lead | Service Owner |
| Pre-test | nmap: 8080 open | /archive/ and file = 200 | UFW inactive | index.html present; hash taken |
| Executed | 2026-11-09 11:38:49 UTC | 2026-11-09 ~14:02 UTC | 2026-11-09 between 14:02 and 14:54 UTC | 2026-11-09 23:52:22 UTC; restored 2026-11-10 00:00:33 UTC |
| Post-test | 8080 closed; portal 200 | /public/ 200; /, /archive/, file 403 | approved 200; unapproved timed out + UFW BLOCK | hash OK; portal 200 |
| Rollback | systemctl enable --now grc-legacy | restore baseline nginx conf; move archive back; reload | sudo ufw disable (console) | restore from tarball |
| Rollback tested? | YES - enabled 12:44:59 UTC (8080 listening, Kali got the endpoint), disabled again 12:48:37 UTC | Documented, not tested | Documented, not tested | YES - restore performed |
| Final state | Legacy disabled | Archive private | UFW active | Portal restored |
