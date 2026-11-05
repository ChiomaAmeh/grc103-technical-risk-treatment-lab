# Four-Strategy Treatment Decision Records (approvals SIMULATED)
Student: Chioma Ameh | ID: C11/26/CGRCE/17567

## TDR-1 AVOIDANCE — retire the legacy endpoint (R1)
- Decision: stop and disable `grc-legacy`; keep the approved portal.
- Why avoidance fits: the service has no business need, so removing the activity removes its exposure (no ongoing control cost).
- Evidence: baseline-ports.txt (8080 open) vs avoidance-ports.txt (8080 closed); portal still 200.
- Limits: avoids the legacy workflow's risk only. Port 80 (plain HTTP, Nginx, host OS) still carries risk — see R2–R4.
- Owner: IT Operations Manager (simulated) | Approval: SIMULATED | Review: drift check daily.

## TDR-2 MITIGATION — archive hardening + UFW + logging + backup (R2, R3, R4)
- Preventive: archive moved outside web root, root-only permissions, explicit deny; UFW default-deny with one allowed source.
- Detective: Nginx access log + UFW kernel log.
- Corrective: backup and restore with hash verification.
- Evidence: archive-*.txt (403s), test-results.csv, UFW rules/logs, recovery evidence.
- Residual risk: see register Part B (plain HTTP, source-IP trust, same-host backup).
- Owners: Data Owner / Security Lead / Service Owner (simulated).

## TDR-3 TRANSFER — managed backup (R4)
- Offer (fictional): $120 setup + $20/month vs local-only backup.
- Provider duties: scheduled off-host backups, separate-location copies, encryption at rest, restore support within an agreed time.
- Retained customer duties: decide what is backed up, protect credentials, run and evidence restoration tests, maintain the live service.
- Restoration-test requirement: at least quarterly, with SHA-256 comparison and recorded recovery time.
- Evidence-retention requirement: keep test reports and logs for 12 months (assumed policy).
- Service limitation: the provider restores backups only; it does not prevent deletion, compromise or misconfiguration at source.
- Proposed clause (draft): "The Provider shall perform daily encrypted off-site backups of the Customer Portal data set, retain 30 days of versions, and complete a Customer-requested restore within 4 business hours. The Customer remains responsible for data classification, access credentials and quarterly restoration tests, the results of which the Provider shall help evidence. The Provider's liability is limited to the fees paid for the affected period."
- A contract or insurance does NOT remove the technical risk; it moves some cost and duty. No purchase is made.

## TDR-4 ACCEPTANCE — temporary plain HTTP on the isolated network
- Question: may HTTP (no TLS) be kept temporarily, dummy data only, isolated host-only network?
- Owner: Service Owner (simulated) | Approval: SIMULATED
- Residual risk score: L __ x I __ = __ (suggested L2 x I2 = 4 Low: dummy data, isolated network, one allowed source — keep only if you agree)
- Rationale: nothing sensitive is exposed; TLS cost (Option C) is not justified until real data or wider access appears.
- Proposed expiry: 14 days from ____ | Review date: ____
- Triggers for re-evaluation: any real/personal data; any external or bridged connectivity; more than one client or a broader network; a change in portal purpose.
- If any trigger occurs the acceptance is void: escalate and implement Option C (TLS).
