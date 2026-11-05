# Monitoring and Operational Handover
Student: Chioma Ameh | ID: C11/26/CGRCE/17567

**Measured in the lab:** tests in test-results.csv and the recovery time in the report.
**Proposed (not measured):** everything in the table below.

| # | Check | Owner (simulated) | Frequency | Threshold | Escalation |
|---|---|---|---|---|---|
| M1 | Portal availability: `curl -s -o /dev/null -w '%{http_code}' http://SERVER/public/` from approved client | Service Owner | Every 5 min | Non-200 on 2 consecutive checks | Page IT Ops; start restore after 15 min |
| M2 | Unexpected open ports: `nmap -sT -p 1-10000 SERVER` vs approved list (80 only) | Security Lead | Daily | Any port other than 80 open | Incident ticket within 1 hour; close port and investigate |
| M3 | Recovery-test success: restore + `sha256sum -c` | Service Owner | Monthly (quarterly with managed backup) | Hash mismatch or recovery > 15 min | Fix backup process within 5 business days; re-test |
| M4 | Drift check: `systemctl is-enabled grc-legacy` must not be `enabled`; port 8080 closed | IT Ops Manager | Daily | Service enabled/active or 8080 open | Treat as change-control breach; disable and review who changed it |
| M5 | UFW active with expected rules: `ufw status numbered` | Security Lead | Daily | UFW inactive or extra allow rules | Restore ruleset from baseline; open incident |

Leading indicators: M2, M4, M5 (drift/exposure). Lagging indicators: portal downtime minutes, failed restore tests.
