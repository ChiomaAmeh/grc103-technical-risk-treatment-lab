# Risk Register - Northbridge Services (fictional)
Student: Chioma Ameh | Reg. No. C11/26/CGRCE/17567

Scale: likelihood 1-5 x impact 1-5 = score. Bands (course exercise): 1-4 Low, 5-9 Medium, 10-16 High, 17-25 Critical.
Scores are ordinal judgements - NOT money or probabilities. Owners and approvals are simulated.

## A. Baseline (before treatment) - measured on 9 Nov 2026
| ID | Asset | Threat event | Observed weakness | L | I | Score / Band | Evidence | Owner (simulated) |
|----|-------|--------------|-------------------|---|---|--------------|----------|-------------------|
| R1 | Legacy endpoint :8080 | Unused service reached or abused | Open on 0.0.0.0:8080, no business need | 4 | 3 | 12 High | evidence/kali/baseline-ports.txt, baseline-legacy.txt | IT Operations Manager |
| R2 | /archive (dummy records) | Unauthorised disclosure | Directory listing on; file downloadable | 4 | 4 | 16 High | baseline-listing.txt, baseline-file.txt | Data Owner |
| R3 | Server network exposure | Any host reaches services | UFW inactive; any source reaches :80/:8080 | 4 | 3 | 12 High | evidence/ubuntu/baseline-ufw.txt, baseline-ss.txt | Security Lead |
| R4 | Approved portal content | Accidental deletion -> outage | No backup existed | 3 | 3 | 9 Medium | (no backup before test) | Service Owner |

## B. Residual (after treatment)
| ID | Residual L | Residual I | Score / Band | Basis | Remaining weakness | Review trigger | Status |
|----|-----------|-----------|--------------|-------|--------------------|----------------|--------|
| R1 | 1 | 3 | 3 Low | 8080 closed; rollback proven (avoidance-*.txt, screenshots 09b/10c) | Service could be re-enabled by mistake | New open port (daily scan) | Tested |
| R2 | 2 | 4 | 8 Medium | /, /archive/, file = 403 (archive-*.txt, 12b) | Plain HTTP; allow-list relies on source IP | Real data stored; web-root change | Tested |
| R3 | 2 | 3 | 6 Medium | Approved 200; unapproved dropped + UFW BLOCK log (test-results.csv, 15c) | Source IP can be spoofed on a shared network; no TLS | New client/subnet; rule change | Tested |
| R4 | 2 | 3 | 6 Medium | Restore with SHA-256 OK in 490 s (recovery-*.txt, 17) | Backup is on the same host | Failed restore test; host change | Tested |

Residual scores are my judgement from the observed tests; the remaining weaknesses are why none is scored 1.
