# Four-Strategy Treatment Decision Records (approvals SIMULATED)
Student: Chioma Ameh | Reg. No. C11/26/CGRCE/17567

## TDR-1 AVOIDANCE - retire the legacy endpoint (R1)
- Decision: stop and disable grc-legacy; keep the approved portal.
- Why: no business need, so removing the activity removes its exposure with no running cost.
- Evidence: 8080 open (baseline) -> closed (avoidance); portal 200 throughout.
- Limit: avoids only the legacy workflow's risk; port 80, plain HTTP and file loss remain (R2-R4).
- Owner: IT Operations Manager (simulated). Approval: SIMULATED. Review: daily drift check.

## TDR-2 MITIGATION - archive protection, firewall, logging, backup (R2, R3, R4)
- Preventive: archive moved out of web root, root-only permissions, explicit deny; UFW default-deny, one allowed source.
- Detective: Nginx access log + UFW kernel log. Corrective: backup with hash-verified restore (490 s observed).
- Residual: R2 8 Medium, R3 6 Medium, R4 6 Medium (plain HTTP, source-IP trust, same-host backup).
- Owners: Data Owner / Security Lead / Service Owner (simulated).

## TDR-3 TRANSFER - managed off-host backup (R4, host loss)
- Offer (fictional): $120 setup + $20/month ($360 first year) vs local-only backup.
- Provider: scheduled encrypted off-site backups, version retention, restore support within an agreed time.
- Customer keeps: data classification, credentials, quarterly restoration tests with SHA-256 and recorded time, evidence kept 12 months (assumed policy).
- Limitation: the provider restores backups only; it does not prevent deletion, compromise or misconfiguration at source. A contract or insurance does not remove the technical risk.
- Draft clause: "The Provider shall perform daily encrypted off-site backups of the Customer Portal data set, retain 30 days of versions and complete a Customer-requested restore within 4 business hours. The Customer remains responsible for data classification, access credentials and quarterly restoration tests. The Provider's liability is limited to the fees paid for the affected period."
- No purchase made. Owner: Service Owner (simulated).

## TDR-4 ACCEPTANCE - temporary plain HTTP on the isolated network
- Question: keep HTTP (no TLS) temporarily - dummy data only, isolated host-only network, one allowed source?
- Owner: Service Owner (simulated). Approval: SIMULATED.
- Residual risk: L2 x I2 = 4 Low.
- Rationale: nothing sensitive is exposed; the TLS cost (Option C, $100) is not justified until real data or wider access appears.
- Proposed expiry: 14 days from 2026-11-10 = 2026-11-24. Review date: 2026-11-17.
- Re-evaluation triggers: any real or personal data; any external or bridged connectivity; more than one client or a wider network; a change in portal purpose. If triggered, acceptance is void and TLS is implemented.
