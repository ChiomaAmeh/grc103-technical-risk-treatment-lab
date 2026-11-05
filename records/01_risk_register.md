# Risk Register — Northbridge Services (fictional)
Student: Chioma Ameh | ID: C11/26/CGRCE/17567

Scale: likelihood 1–5 × impact 1–5 = score. Bands: 1–4 Low, 5–9 Medium, 10–16 High, 17–25 Critical.
Classroom thresholds only (not an external standard). Scores are ordinal — NOT money or probabilities.

> PROVISIONAL scores below. Keep or change them only if your own baseline evidence supports it.

## A. Baseline (before treatment)
| ID | Asset | Threat event | Observed weakness | L | I | Score / Band | Evidence ref | Treatment owner |
|----|-------|--------------|-------------------|---|---|--------------|--------------|-----------------|
| R1 | Legacy endpoint (port 8080) | Unused service reached/abused by any host | Open on 0.0.0.0:8080, no business need | 4 | 3 | 12 High | baseline-ports.txt; baseline-legacy.txt | IT Operations Manager (simulated) |
| R2 | /archive directory (dummy records) | Unauthorised disclosure of records | Directory listing ON, file downloadable | 4 | 4 | 16 High | baseline-listing.txt; baseline-file.txt | Data Owner (simulated) |
| R3 | Document server network exposure | Unauthorised host reaches services | No firewall restriction; any source reaches :80/:8080 | 4 | 3 | 12 High | ubuntu/baseline-ufw.txt | Security Lead (simulated) |
| R4 | Approved portal content | Accidental deletion/corruption → outage | No backup existed before treatment | 3 | 3 | 9 Medium | (state: no backup before test) | Service Owner (simulated) |

## B. Residual (after treatment) — fill from ACTUAL tests
| ID | Residual L | Residual I | Score / Band | Evidence | Owner | Review trigger | Status (Tested / Configured-untested) |
|----|-----------|-----------|--------------|----------|-------|----------------|-------------------------------------|
| R1 | | | | avoidance-ports.txt | | new unexpected open port | |
| R2 | | | | archive-*.txt | | real data stored; web root change | |
| R3 | | | | test-results.csv F1–F3 + UFW log | | new client/subnet; rule change | |
| R4 | | | | recovery-*.txt, hash check | | recovery test fails; host change | |

Guidance: R1 — removing 8080 lowers likelihood sharply, impact unchanged. R2/R3 — plain HTTP remains and the firewall
is a single source-IP check (IPs can be spoofed on a shared network), so do not score these as 1.
R4 — a same-host backup does not survive host loss; keep residual impact honest.
