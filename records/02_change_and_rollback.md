# Change and Rollback Records (all approvals SIMULATED)
Student: Chioma Ameh | ID: C11/26/CGRCE/17567

| Field | CHG-01 Retire legacy service | CHG-02 Remove archive publication | CHG-03 UFW source restriction | CHG-04 Backup/restore exercise |
|---|---|---|---|---|
| Proposed change | Disable `grc-legacy` (port 8080) | Move archive to /srv/grc-private, root-only; autoindex off; deny /archive/ | Default deny incoming; allow Kali IP to tcp/80 | tar backup + sha256, delete, restore |
| Business impact | None: legacy endpoint unused; portal unaffected | None for /public/; old URLs return 403 | Only the approved client reaches the portal | Brief intentional portal outage (lab) |
| Approval role | IT Ops Manager (simulated) | Data Owner (simulated) | Security Lead (simulated) | Service Owner (simulated) |
| Pre-test | nmap shows 8080 open | /archive/ returns 200 | UFW inactive; all sources reach :80 | index.html present, hash taken |
| Post-test | 8080 closed; :80 still 200 | /public/ 200; /, /archive/ 403 | Kali 200; unapproved IP times out + UFW BLOCK log | hash OK; /public/ 200 |
| Rollback | `sudo systemctl enable --now grc-legacy` | restore baseline nginx conf + `mv` archive back; reload | `sudo ufw disable` (console) | restore from tarball |
| Rollback tested? | (yes/no + date) | | | |
| Final state | Legacy DISABLED | Archive private | UFW enabled | Portal restored |
| Executed (timestamp) | | | | |
