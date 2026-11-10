# Management Summary
Northbridge Services - Technical Risk Treatment | Chioma Ameh | Reg. No. C11/26/CGRCE/17567

**Situation.** The internal document server exposed an unnecessary legacy service (port 8080) and a browsable directory of records, with no network restrictions and no backup.

**What was done and proved (measured).** The legacy service was retired: port 8080 went from open to closed while the approved portal stayed at HTTP 200; the change was rolled back and re-applied successfully. The archive was moved out of the web root: direct access to the records file went from 200 to 403. A source-based firewall now allows only the approved client: the approved source received 200, the unapproved source timed out, and the kernel log recorded [UFW BLOCK] for it while Nginx logged nothing. A deleted portal file was restored from backup with a matching SHA-256 hash in 490 seconds (including manual steps).

**Residual risk.** Plain HTTP remains; the allow-list relies on the source IP; the backup is on the same host. Residual scores: R1 3 Low, R2 8 Medium, R3 6 Medium, R4 6 Medium.

**Recommendation (assumption-based costs).** Adopt Option A hardening (done, $150), Option C TLS ($100) and Option B managed off-host backup ($360): total first-year cost $610. Accept plain HTTP only temporarily (14 days, dummy data only, simulated approval) until TLS is in place.

**Monitoring.** Five checks - availability, open ports, recovery test, retired-service drift, firewall state - each with owner, threshold and escalation (records/05_monitoring_plan.md).

**Decisions needed.** Approve the 14-day acceptance and the TLS plus managed-backup budget (simulated).

*Measured results come from the laboratory; approvals, financial figures and the managed-backup offer are simulated or assumed.*
