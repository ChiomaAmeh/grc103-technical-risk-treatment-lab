# Management Summary (one page)
Northbridge Services — Technical Risk Treatment | Student: Chioma Ameh | ID: C11/26/CGRCE/17567

**Situation.** The internal document server exposed an unnecessary legacy service (port 8080) and a browsable directory of records, with no network restrictions and no backup.

**What was done and proved (measured).** [Fill from your results] Legacy service retired (8080 open -> closed, portal still HTTP 200); archive moved out of the web root (direct file access 200 -> 403); firewall restricts access to the approved client (unapproved source timed out; UFW BLOCK log: found/not found); a deleted portal file was restored with matching SHA-256 in ___ seconds.

**Residual risk.** [Fill] Plain HTTP remains; the allow-list relies on source IP; the backup is on the same host. Residual scores: R1 __, R2 __, R3 __, R4 __.

**Recommendation.** Adopt Option A (hardening) and Option C (TLS); add Option B (managed off-host backup) to cover host loss. Total first-year cost $610 (fictional, assumption-based). Accept plain HTTP only temporarily (14 days, dummy data only, simulated approval) until TLS is in place.

**Monitoring.** Five checks (availability, open ports, recovery test, retired-service drift, firewall state) with owners and escalation — see monitoring plan.

**Decisions needed.** Approve the 14-day acceptance and the TLS + managed-backup budget (simulated).

*Measured results come from the lab. Financial figures and approvals are assumptions/simulations.*
