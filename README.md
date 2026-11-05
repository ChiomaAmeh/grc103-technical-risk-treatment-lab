# Technical Risk Treatment Lab — Northbridge Services (fictional)

**Student:** Chioma Ameh  **Registration No.:** C11/26/CGRCE/17567
**Course:** GRC103 Risk Assessment and Management Techniques — Module 3 (ICDFA)

Lab: Ubuntu Server 24.04 (target) + Kali Linux (tester) on an isolated host-only network.
All data is fictional. No passwords, private keys or VM disk images are included.

## Evidence index (maps evidence to lab steps)
| Step | What | Where |
|---|---|---|
| 1–3 | Build lab, packages, services, checkpoint | `evidence/ubuntu/ip-addr-*.txt`, `evidence/screenshots/`, `configs/` |
| 4 | Baseline scan + curl outputs | `evidence/kali/baseline-*.txt`, `evidence/ubuntu/baseline-ufw.txt`, `baseline-ss.txt` |
| 5 | Risk register | `records/01_risk_register.md` |
| 6 | Avoidance (legacy retired) | `evidence/kali/avoidance-*.txt`, `evidence/ubuntu/avoidance-*.txt`, `records/02_change_and_rollback.md` |
| 7 | Archive hardening | `evidence/kali/archive-*.txt`, `configs/nginx-grc-lab-TREATED.conf` |
| 8 | UFW rules + allowed/blocked tests | `evidence/ubuntu/ufw-status-numbered.txt`, `evidence/kali/firewall-*.txt`, `evidence/kali/test-results.csv` |
| 9 | Log correlation | `evidence/ubuntu/nginx-access-extract.txt`, `evidence/ubuntu/ufw-block-log.txt`, `records/04_evidence_table*.md` |
| 10 | Backup and recovery | `evidence/ubuntu/recovery-*.txt`, `evidence/kali/recovery-*.txt` |
| 11 | Transfer + acceptance | `records/03_treatment_decision_records.md` |
| 12 | Costs, ALE, residual risk | `calculations/cost_analysis.xlsx`, report section 7 |
| Monitoring | Monitoring plan | `records/05_monitoring_plan.md` |
| Summary | One-page management summary | `records/06_management_summary.md` |
| Demo | Recorded demonstration | `evidence/recording/` (link in report section 9) |

## Layout
`report/` report source + final PDF · `records/` registers and decisions · `configs/` config files ·
`scripts/kali_tests.sh` test helper · `calculations/` workbook · `evidence/` raw outputs and screenshots.

## Honesty note
Measured results = lab outputs. Approvals are **simulated**. Costs and ALE values are **assumptions**.
Anything not collected is marked *unverified*, not fabricated.
