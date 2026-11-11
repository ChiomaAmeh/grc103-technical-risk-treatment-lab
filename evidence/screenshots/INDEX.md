# Screenshot Index — Chioma Ameh | C11/26/CGRCE/17567

Status: **Included** = file is in this folder. **TO TAKE** = still to capture during the lab.
Ubuntu's clock runs ~15 minutes behind Kali's (NAT disconnected, no time sync); log times are compared with that offset.

| # | File | Lab step | What it proves | Status |
|---|---|---|---|---|
| 00a | 00a_ubuntu_install_complete.png | Setup | Ubuntu Server 24.04 installed | Included |
| 00b | 00b_ubuntu_first_login.png | Setup | First login, enp0s3 NAT address | Included |
| 00c | 00c_ubuntu_server_install_type.png | Setup | Standard Ubuntu Server (not minimized), no third-party drivers | Included |
| 00d | 00d_ubuntu_storage_summary.png | Setup | 25 GB virtual disk layout (isolated VM disk only) | Included |
| 00e | 00e_ubuntu_packages_installed.png | Setup | nginx 1.24.0, ufw, python3, curl installed | Included |
| 01a | 01a_ubuntu_identity.png | Setup | Student name/ID, Ubuntu 24.04.5 LTS, VirtualBox, clock | Included |

| 01 | 01_vbox_kali_snapshot1_vm_list.png | Setup | VirtualBox Manager: Kali with 'Snapshot 1' (existing checkpoint), 2 vCPU / 2 GB, adapters NAT + Host-only; other VMs powered off | Included |
| 01b | 01b_vbox_vm_list_both_running.png | Setup | Kali and ubuntu-server both running during the lab | Included |
| 02 | 02_ubuntu_adapter2_hostonly.png | Setup | Host-only isolated network adapter | Included |
| 03 | (not taken) | Setup | Kali checkpoint is 'Snapshot 1' (screenshot 01). Ubuntu was built from scratch for the lab; no pre-lab snapshot exists - rollback is via the documented per-change rollback steps | n/a |
| 04 | 04_kali_ip_addr.png | Setup | Kali eth1 = 192.168.56.101 | Included |
| 05 | 05_ubuntu_build_ports_nat_down.png | Steps 3-4 | :80 and :8080 listening, UFW inactive, NAT adapter down, host-only up | Included |
| 06 | 06_kali_baseline_nmap_listing.png | Step 4 | Baseline: 80 and 8080 open; browsable listing of archive/ and public/ | Included |
| 07 | 07_kali_baseline_file_legacy_results.png | Step 4 | Dummy record readable; legacy endpoint answers; B1-B3 = 200 | Included |
| 08a | 08a_ubuntu_baseline_config.png | Step 7 (before) | Archive inside web root; autoindex on | Included |
| 09 | 09_avoidance_ubuntu.png | Step 6 | legacy service inactive/disabled; 8080 gone, 80 still listening | Included |
| 09b | 09b_rollback_ubuntu_enable_disable.png | Step 6 rollback | Legacy re-enabled 12:44:59 UTC (8080 listening) then disabled 12:48:37 UTC (8080 gone) | Included |
| 09c | 09c_legacy_retired_final.png | Step 6 | Final state: nothing listening on 8080 | Included |
| 10 | 10_avoidance_kali.png | Step 6 | 8080 closed (A1); approved portal still 200 (A2) | Included |
| 10b | 10b_rollback_kali_legacy_back.png | Step 6 rollback | Kali reaches legacy endpoint while rollback active | Included |
| 10c | 10c_avoidance_final_kali.png | Step 6 | Final state re-test: 8080 closed, portal 200 | Included |
| 11 | 11_archive_hardening.png | Step 7 | /srv/grc-private drwx------ root root; Nginx autoindex off + deny all on /archive/ | Included |
| 12 | 12_archive_403s_kali.png | Step 7 | /public/ = 200; / and /archive/ = 403 | Included |
| 12b | 12b_archive_results_csv.png | Step 7 | P1 /public/=200; P2 /, P3 /archive/, P4 /archive/dummy-records.txt = 403 | Included |
| 13 | 13_ufw_rules.png | Step 8 | UFW active; default deny (incoming); only 192.168.56.101 allowed to 80/tcp; logging on (low). One mistyped sudo password ('Sorry, try again') is visible and harmless | Included |
| 14a | 14a_firewall_allowed_kali.png | Step 8 | Approved source 192.168.56.101 gets 200 (F1, 15:59:46+01:00) | Included |
| 14b | 14b_firewall_blocked_kali.png | Step 8 | Unapproved source 192.168.56.30 times out (F2 16:22:51, F3 16:22:59 +01:00) | Included |
| 15 | 15_logs_nginx_ufw.png | Step 9 | Nginx log: only 192.168.56.101 (200/403); no entry for 192.168.56.30. Kernel log: [UFW BLOCK] SRC=192.168.56.30 DST=192.168.56.20 DPT=80 SYN, two connection attempts (15:18:45-49 and 15:18:53-57 Ubuntu clock) | Included |
| 15b | 15b_kali_test_rows.png | Step 9 | Kali test-results.csv rows F2, F3, L1, L2 with timestamps used for log matching | Included |
| 15c | 15c_ufw_block_full.png | Step 9 | Complete UFW BLOCK log for 192.168.56.30: attempt 1 at 15:18:44-49 (SPT 54606), attempt 2 at 15:18:53-57 (SPT 35810) | Included |
| 16 | 16_backup_delete.png | Step 10 | Backup tarball (177 bytes), SHA-256 e5b34d9b...50f72 of index.html, start 2026-11-09T23:52:22+00:00, file deleted. A typo'd restore command (u6a_restore.sh, no such file) is visible and harmless | Included |
| 16b | 16b_recovery_fail_kali.png | Step 10 | After deletion /public/ returns 403 (not 200) - R1, 2026-11-10T09:49:00+01:00 | Included |
| 17 | 17_restore_hash_time.png | Step 10 | Restored from backup: sha256sum -c = OK; end 2026-11-10T00:00:33+00:00; Recovery time 490 seconds (start 2026-11-09T23:52:22+00:00; includes the Kali check and a mistyped command, not a pure automated restore) | Included |
| 17b | 17b_final_state_ubuntu_and_shipping.png | Final state | nginx active; grc-legacy disabled; UFW active (only 192.168.56.101 -> 80/tcp); only :80 listening (no :8080); then Ubuntu evidence files copied to Kali with scp | Included |
| 17c | 17c_recovery_ok_kali.png | Step 10 | R1 403 after deletion, then R2 200 after restore (2026-11-10T09:57:41+01:00) | Included |
| 18a | 18_kali_commit_push_evidence.png | Submission | Evidence committed and pushed to GitHub (780f7ce..3095c43) | Included |
| 18 | (workbook, not a screenshot) | Steps 11-12 | Costs, ALE and recovery time are in calculations/cost_analysis.xlsx | n/a |
| 19 | 19_github_repo_final.png | Submission | Final repository state (take after the last upload) | TO TAKE after upload |

Excluded on purpose: the first baseline run (09:07), taken before the server was built; it showed the default nginx page and port 8080 closed, so it is NOT valid baseline evidence.
