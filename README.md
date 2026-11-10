# Technical Risk Treatment Lab - Northbridge Services (fictional)

| | |
|---|---|
| **Student** | Chioma Ameh |
| **Registration No.** | C11/26/CGRCE/17567 |
| **Course** | GRC103 Risk Assessment and Management Techniques - Module 3 practical (ICDFA) |
| **Repository** | https://github.com/ChiomaAmeh/grc103-technical-risk-treatment-lab |
| **Final report (PDF)** | [`report/Technical_Risk_Treatment_Report_Chioma_Ameh_C11-26-CGRCE-17567.pdf`](report/) |
| **Recorded demonstration** | https://drive.google.com/file/d/1ylNHqidJy-WEECjVXbpER1MnK2liPe3q/view?usp=drive_link |

> All data is fictional. I used only my own isolated laboratory systems. This repository contains no passwords, tokens, private keys, or VM disk images.
> **Measured results** come from my lab outputs. **Approvals, the managed-backup offer, costs, and annual-loss figures are simulated or assumed** and are labelled as such.

---

## 1. What this lab proves

I acted as a GRC analyst and technical control implementer for Northbridge Services. Its internal document server exposed an unnecessary legacy service and a browsable directory of records. I built a baseline, implemented four treatments, validated each with tests and logs, restored a deleted file with hash verification, and justified avoidance, mitigation, transfer, and acceptance decisions.

| Risk | Baseline | Treatment | Measured result (before -> after) | Residual |
|---|---|---|---|---|
| **R1** Legacy endpoint :8080 | 4x3 = 12 High | Avoidance - retire the service | port 8080 **open -> closed**; approved portal stays **200** | 3 Low |
| **R2** /archive records exposed | 4x4 = 16 High | Mitigation - move out of web root, root-only, autoindex off, explicit deny | `/archive/dummy-records.txt` **200 -> 403**; `/` **200 -> 403** | 8 Medium |
| **R3** No network restriction | 4x3 = 12 High | Mitigation - UFW default deny, one allowed source | approved `.101` **200**; unapproved `.30` **timeout** + `[UFW BLOCK]` log, no Nginx entry | 6 Medium |
| **R4** No backup / outage | 3x3 = 9 Medium | Mitigation (backup) + Transfer (managed off-host backup, proposed) | deleted file restored, SHA-256 **OK**, **490 s** | 6 Medium |
| Plain HTTP | - | Acceptance (temporary, 14 days, dummy data) | - | 4 Low |

Scale: likelihood (1-5) x impact (1-5); bands 1-4 Low, 5-9 Medium, 10-16 High, 17-25 Critical. Scores are ordinal judgements, not money or probabilities.

---

## 2. Laboratory architecture

```
        Windows 11 Pro host (HP, Core i7 8th gen) - Oracle VirtualBox
   +-------------------------------------------------------------------+
   |   Host-only network (isolated)  192.168.56.0/24                   |
   |                                                                   |
   |   Kali Linux 2025.4  (tester)        Ubuntu Server 24.04.5 (target)|
   |   eth1  192.168.56.101  ------------>  enp0s8 192.168.56.20       |
   |   (approved source)        HTTP:80      Nginx 1.24  /public/       |
   |   +192.168.56.30 (temporary,            UFW: allow .101 -> 80/tcp  |
   |    unapproved test source)              legacy: 8080 RETIRED       |
   |   eth0 = NAT (Git/GitHub only)          enp0s3 = NAT, taken DOWN   |
   +-------------------------------------------------------------------+
```

| Item | Value |
|---|---|
| Ubuntu | Server 24.04.5 LTS, 2 vCPU, 2 GB RAM, 25 GB disk, host `ubuntu`, host-only `192.168.56.20` |
| Kali | 2025.4, host-only `192.168.56.101` (eth1) |
| Software | Nginx 1.24.0, UFW 0.36.2, Python 3.12 (legacy endpoint), curl, nmap 7.95 |
| NAT handling | Ubuntu's NAT adapter was used only to install packages, then taken down (`ip link set enp0s3 down`) before any baseline scan. Kali's NAT stayed up only to push to GitHub. |
| Console limitation | The VirtualBox text console cannot paste, so long command sequences were saved as scripts (`scripts/u1_build.sh` ... `u7_ship.sh`), served from Kali, downloaded to Ubuntu, and run on the Ubuntu console. |

---

## 3. Repository layout

```
README.md                          <- this file
demo/DEMO_SCRIPT.md (+ PDF)        <- read-along script for the recorded demonstration
report/                            <- final PDF report (+ report source skeleton)
records/
  01_risk_register.md              baseline and residual risk register
  02_change_and_rollback.md        change + rollback records (approvals simulated)
  03_treatment_decision_records.md avoidance / mitigation / transfer/acceptance
  04_evidence_table.md             every test: source, request, expected, actual, timestamps, log lines, clock offsets
  05_monitoring_plan.md            five monitoring checks with owners, thresholds, escalation
  06_management_summary.md         one-page management summary
calculations/cost_analysis.xlsx    option costs, ALE scenario, recovery-time sheet (formulas)
configs/                           grc-legacy.service, Nginx baseline and treated configs
scripts/                           kali_tests.sh (tester) and u1_build.sh ... u7_ship.sh (Ubuntu)
evidence/
  kali/                            raw outputs from the Kali tests (baseline, avoidance, archive, firewall, recovery) + test-results.csv
  ubuntu/                          raw outputs from the server (ports, UFW, configs, backup, recovery) - copied with scp
  screenshots/                     numbered screenshots + INDEX.md
```

---

## 4. Step-by-step: what I did and where the evidence is

| Brief step | What I did | Evidence |
|---|---|---|
| 1-3 Build the lab | Ubuntu Server + Kali on an isolated host-only network; installed Nginx/UFW/Python; created fictional content, the legacy `grc-legacy` systemd service (port 8080) and the browsable archive; took NAT down | `configs/`, `scripts/u1_build.sh`, screenshots 00a-00e, 02, 04, 05 |
| 4 Baseline | nmap + curl from Kali **before** any change; `ufw status` and `ss -lntp` on Ubuntu | `evidence/kali/baseline-*.txt`, `evidence/ubuntu/baseline-ufw.txt`, `baseline-ss.txt`, screenshots 06, 07, 08a |
| 5 Risk register | R1-R4 scored with evidence references | `records/01_risk_register.md` |
| 6 Avoidance | `systemctl disable --now grc-legacy`; verified 8080 closed and portal 200; **rollback tested** (re-enabled then disabled) | `evidence/*/avoidance-*.txt`, screenshots 09, 09b, 09c, 10, 10b, 10c |
| 7 Archive protection | Moved archive to `/srv/grc-private` (root-only), `autoindex off`, `deny all` for `/archive/`; Nginx test and reload | `configs/nginx-*.conf`, `evidence/kali/archive-*.txt`, screenshots 08a, 11, 12, 12b |
| 8 Firewall | UFW default deny incoming; allow only `192.168.56.101` to tcp/80; logging on; tested approved vs unapproved (`192.168.56.30`) | `evidence/ubuntu/ufw-status-*.txt`, `evidence/kali/firewall-*.txt`, screenshots 13, 14a, 14b |
| 9 Log correlation | Matched Kali tests to Nginx log lines and kernel `[UFW BLOCK]` lines; measured the clock offset per test group | `evidence/ubuntu/nginx-access-extract.txt`, `ufw-block-log.txt`, `records/04_evidence_table.md`, screenshots 15, 15b, 15c |
| 10 Backup and recovery | tar backup + SHA-256; deleted `index.html`; portal 403; restored; `sha256sum -c` OK; **490 s** | `evidence/ubuntu/backup-*.txt`, `recovery-*.txt`, `evidence/kali/recovery-*.txt`, screenshots 16, 16b, 17, 17c |
| 11 Decisions | Four strategies with owners, limits, expiry and triggers | `records/03_*`, `records/02_*` |
| 12 Costs and residual risk | Option costs, ALE scenario, residual scores, monitoring, management summary | `calculations/cost_analysis.xlsx`, `records/01`, `05`, `06`, report Section 7-10 |

### Required evidence checklist (from the assignment)
1. **Baseline assessment and risk register** - baseline files, screenshots 05-07, 08a, `records/01`
2. **Avoidance and preventive controls** - avoidance, archive, and firewall evidence (steps 6-8)
3. **Control validation and logs** - `records/04_evidence_table.md` (permitted and blocked tests, timestamps, source addresses, log extracts)
4. **Backup and recovery** - backup, simulated loss, restoration, hash verification, observed recovery time (490 s)
5. **Treatment decisions and financial analysis** - `records/03`, `calculations/cost_analysis.xlsx`, residual risk in `records/01`
6. **Management report and evidence index** - report PDF, `records/06`, `records/05`, `records/02`, this README
7. **Demonstration** - recorded video (link at top), script in `demo/`

---

## 5. Key results in detail

**Baseline (9 Nov 2026, 12:48 WAT)** - nmap: `80/tcp open`, `8080/tcp open`. `GET /` returned a directory listing of `archive/` and `public/`; `/archive/dummy-records.txt` returned 200; `:8080` returned "Legacy training endpoint"; UFW was inactive.

**After treatment**

| Test | Source | Result |
|---|---|---|
| `/public/` | 192.168.56.101 (approved) | **200** |
| `/` , `/archive/` , `/archive/dummy-records.txt` | 192.168.56.101 | **403** |
| `:8080` | 192.168.56.101 | no connection (service stopped; closed) |
| `/public/` | 192.168.56.30 (unapproved) | **timeout** - kernel `[UFW BLOCK] SRC=192.168.56.30 DPT=80 SYN`; **no Nginx log line** |
| `/public/` after `rm index.html` | 192.168.56.101 | **403** |
| `/public/` after restore | 192.168.56.101 | **200**; `sha256sum -c` = OK |

**Backup:** hash before deletion `e5b34d9b4fa6452b6b1d292b0ced654c99977f7ebece28a2731f633f53a50f72`; deleted 2026-11-09 23:52:22 UTC; restored 2026-11-10 00:00:33 UTC (Ubuntu clock); **490 s** observed.

**Costs (fictional, assumptions)** - A hardening $150 (4 h x $25 + $50); B managed backup $360 ($120 + $20 x 12); C TLS $100 (3 h x $25 + $25); chosen A+B+C = **$610**. Illustrative scenario: ARO 0.2, loss $5,000 -> $1,000 with tested recovery; ALE $1,000 -> $200; annual benefit $800; first-year net benefit of Option B **$440**. These figures are assumptions, not measured, and benefits are not added across options.

---

## 6. Reproduce the lab

1. Create two VMs on a VirtualBox **Host-only** network: Ubuntu Server 24.04 (target) and Kali (tester). Give Ubuntu a temporary NAT adapter for packages, then take it down.
2. On Kali serve the scripts: `cd scripts && python3 -m http.server 8000`.
3. On Ubuntu fetch and run, in order: `bash u1_build.sh` (baseline) -> `u2_avoid.sh` -> `u3_archive.sh` -> `u4_firewall.sh <KALI_IP>` -> `u5_logs.sh` -> `u6a_backup_delete.sh` -> `u6b_restore.sh` -> `u7_ship.sh <kali_user> <KALI_IP>`.
4. After each Ubuntu step run the matching Kali test:
   `export SERVER_IP=192.168.56.20 KALI_IP=192.168.56.101 IFACE=eth1 BLOCK_IP=192.168.56.30`
   `./scripts/kali_tests.sh baseline | avoidance | archive | fw-allowed | fw-blocked | logs | recovery-fail | recovery-ok`
5. Compare your outputs with `records/04_evidence_table.md`.

---

## 7. Limitations and honest notes

- **Clock drift.** Ubuntu had no time sync (NAT down), and its clock drifted and stopped while the VM was paused. The offset to Kali was measured per test group (about 4-15 min on 9 Nov; about 8 h 46 min-8 h 57 min on 10 Nov). Log lines are matched by source address, request sequence, and spacing, as well as time.
- **Recovery time of 490 s** includes the Kali availability check and a mistyped command; the restore itself took about a second.
- **Same-host backup** does not protect against host loss - the reason for the proposed managed off-host backup.
- **Source-IP allow-listing** is a weak control on a shared network (spoofing is possible); production needs authentication and TLS.
- **Rollback** was executed for CHG-01 and CHG-04; for CHG-02 and CHG-03 it is documented but not executed.
- **Order of NAT disconnection.** The exposed services were built, and the NAT interface was taken down immediately afterwards, before any baseline scan, so all tests ran on the isolated network.
- An early baseline run (before the services existed) was discarded and is not used as evidence.
- Approvals, owners, the managed-backup contract, costs, and ALE figures are **simulated or assumed**.

## 8. Security note
No credentials are stored in the repository. `.gitignore` blocks disk images (`*.vdi`, `*.vmdk`, `*.ova`, `*.iso`), keys, and archives. GitHub access used a short-lived personal access token that was never committed.
