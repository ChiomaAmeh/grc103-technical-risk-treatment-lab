---
title: "Technical Risk Treatment: Implementing and Validating Security Controls"
subtitle: "GRC103 Module 3 — Northbridge Services (fictional)"
author: "Chioma Ameh — Registration No. C11/26/CGRCE/17567"
date: "November 2026"
---

# 1. Lab environment
- Host: HP laptop, Intel Core i7 8th gen, Windows 11 Pro; hypervisor: ______ (VirtualBox/VMware)
- Ubuntu Server 24.04 LTS: IP ______ | Kali Linux: IP ______ | Network: host-only/internal `______`
- NAT adapter used only for package installation, then disconnected (date/time: ______)
- Clean checkpoint name: ______ (screenshot in evidence/screenshots/)
- All data fictional; own lab systems only; no passwords, keys or disk images included.

# 2. Baseline and risk register (15 marks)
Evidence: `baseline-ports.txt`, `baseline-web.txt`, `baseline-listing.txt`, `baseline-file.txt`, `baseline-legacy.txt`, Ubuntu `ufw status verbose` and `ss -lntp`.
Observations (what I saw): ______
Risk register: paste `records/01_risk_register.md` Part A.

# 3. Avoidance and continuity (10 marks)
Change record CHG-01 (simulated approval). Evidence: `avoidance-ports.txt` (8080 closed), `avoidance-legacy.txt`, `avoidance-portal.txt` (port 80 still 200), Ubuntu `is-active` and `ss -lntp`. Rollback tested: ______ ; final state: legacy disabled.

**Why avoidance does not eliminate all risk.** Retiring the legacy workflow removes the exposure that came from that workflow only. The Nginx service on port 80, the operating system, plain-HTTP traffic, data in the web root and the possibility of file loss are separate risks that remain and need their own controls (R2–R4).

# 4. Archive hardening and firewall validation (25 marks)
Evidence: `archive-*.txt`, `ufw status numbered`, `firewall-allowed.txt`, `firewall-blocked-time.txt`, `test-results.csv`.

**Why disabling directory listing alone is not enough.** `autoindex off` only stops Nginx generating a file list. If a visitor knows or guesses the exact file URL (e.g. `/archive/dummy-records.txt`), Nginx still serves it because the file sits inside the web root. Real protection needs the file moved out of the web root, restrictive permissions and an explicit deny.

Observations: ______

# 5. Log correlation (10 marks)
Evidence table: paste from `records/04`. Nginx extract: ______ UFW block extract: ______

**Which requests appear in Nginx logs, and why blocked traffic does not.** Nginx logs only requests that reach it: the approved Kali client's `/public/` (200) and `/archive/` (403). UFW (netfilter in the kernel) drops packets from the unapproved source before a TCP connection reaches Nginx, so there is no Nginx entry for it; the evidence is the kernel/UFW log (`UFW BLOCK`) and the client timeout. If a UFW log line is missing (rate limiting or journal issues), the control is *unverified*, not *failed* — stated honestly.

# 6. Backup and verified restoration (15 marks)
Start time ______ ; deletion check (not 200) ______ ; restore time ______ ; `sha256sum -c` = OK ______ ; HTTP 200 restored ______.
**Observed recovery time** = end − start = ______ seconds.

**Same-host backup limitation.** A backup on the same server helps with accidental deletion but is lost together with the host if the disk fails, the host is destroyed, or an attacker or ransomware compromises it. Off-host (ideally offline or immutable) copies are needed for host-loss scenarios.

# 7. Treatment decisions, costs and residual risk (15 marks)
Decision records: `records/03`. Monitoring: `records/05`. Change/rollback: `records/02`.

## 7.1 Cost analysis (fictional first-year prices — ASSUMPTIONS)
First-year cost = setup + labour + annual recurring cost.

| Option | Calculation | First-year cost |
|---|---|---|
| A Hardening | 4 h x $25 + $50 annual maintenance | **$150** |
| B Managed backup | $120 setup + $20 x 12 | **$360** |
| C TLS | 3 h x $25 + $25 annual maintenance | **$100** |

**Chosen combination: A + B + C = $610.** A is already evidenced and low cost; C removes the cleartext-HTTP weakness and ends the need for acceptance; B covers the host-loss gap a local backup cannot.
Excluded costs: staff training, monitoring time, hardware/hypervisor, downtime cost, licences, audit time, end-of-life costs.

## 7.2 Illustrative backup scenario (ALL FIGURES ARE ASSUMPTIONS, separate from lab results)
Annual rate of occurrence 0.2; loss per event $5,000; with tested recovery $1,000.

- Baseline ALE = 0.2 x 5,000 = **$1,000**
- Residual ALE = 0.2 x 1,000 = **$200**
- Annual benefit = 1,000 − 200 = **$800**
- First-year net benefit (Option B) = 800 − 360 = **$440**

The recovery test does not prove these financial figures. Benefits of A, B and C overlap, so they are **not** summed; ordinal risk scores are **not** converted into dollars.

## 7.3 Residual risk
Paste register Part B with actual evidence. Mark untested outcomes as "configured, untested".

# 8. Management summary and evidence index
Management summary: `records/06_management_summary.md` (one page). Evidence index: repository README.

# 9. Demonstration
Recorded demonstration link: ______

# 10. Limitations and honesty statement
Measured results come from my lab tests. Approvals, costs and ALE figures are simulated or assumed. Missing or unverified evidence is stated, not invented.
