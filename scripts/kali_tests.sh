#!/usr/bin/env bash
# Student: Chioma Ameh | ID: C11/26/CGRCE/17567
# Runs the Kali-side tests of the Technical Risk Treatment lab and saves evidence.
# Usage (example):
#   export SERVER_IP=192.168.56.20 KALI_IP=192.168.56.10 IFACE=eth0 BLOCK_IP=192.168.56.11
#   ./kali_tests.sh baseline | avoidance | archive | fw-allowed | fw-blocked | logs | recovery-fail | recovery-ok
set -u
: "${SERVER_IP:?export SERVER_IP first (Ubuntu isolated-network address)}"
EV="${EV:-$HOME/grc-treatment-evidence}"
mkdir -p "$EV"; cd "$EV" || exit 1

# Append one row to test-results.csv (this becomes your evidence table)
# args: TestID Source URL Expected [extra curl args...]
log_test() {
  local id=$1 src=$2 url=$3 exp=$4; shift 4
  local ts code
  ts=$(date -Is)
  code=$(curl -s -o /dev/null --connect-timeout 5 -w '%{http_code}' "$@" "$url")
  [ "$code" = "000" ] && code="NO-RESPONSE(timeout/refused)"
  [ -f test-results.csv ] || echo "test_id,source_ip,url,expected,actual,timestamp" > test-results.csv
  echo "$id,$src,$url,$exp,$code,$ts" | tee -a test-results.csv
}

case "${1:-}" in
baseline)
  date -Is | tee baseline-time.txt
  nmap -sT -p 80,8080 "$SERVER_IP" -oN baseline-ports.txt
  curl -i "http://$SERVER_IP/"                          | tee baseline-web.txt
  curl -i "http://$SERVER_IP/archive/"                  | tee baseline-listing.txt
  curl -i "http://$SERVER_IP/archive/dummy-records.txt" | tee baseline-file.txt
  curl -i "http://$SERVER_IP:8080/"                     | tee baseline-legacy.txt
  log_test B1 "${KALI_IP:-kali}" "http://$SERVER_IP/" "200 (listing)"
  log_test B2 "${KALI_IP:-kali}" "http://$SERVER_IP/archive/dummy-records.txt" "200 (file readable)"
  log_test B3 "${KALI_IP:-kali}" "http://$SERVER_IP:8080/" "200 (legacy open)"
  ;;
avoidance)
  date -Is | tee avoidance-time.txt
  nmap -sT -p 80,8080 "$SERVER_IP" -oN avoidance-ports.txt
  curl -i --connect-timeout 5 "http://$SERVER_IP:8080/" 2>&1 | tee avoidance-legacy.txt
  curl -i "http://$SERVER_IP/public/" | tee avoidance-portal.txt
  log_test A1 "${KALI_IP:-kali}" "http://$SERVER_IP:8080/" "refused/no response"
  log_test A2 "${KALI_IP:-kali}" "http://$SERVER_IP/public/" "200"
  ;;
archive)
  date -Is | tee archive-time.txt
  curl -i "http://$SERVER_IP/public/"                   | tee archive-public.txt
  curl -i "http://$SERVER_IP/"                          | tee archive-root.txt
  curl -i "http://$SERVER_IP/archive/"                  | tee archive-dir.txt
  curl -i "http://$SERVER_IP/archive/dummy-records.txt" | tee archive-file.txt
  log_test P1 "${KALI_IP:-kali}" "http://$SERVER_IP/public/" "200"
  log_test P2 "${KALI_IP:-kali}" "http://$SERVER_IP/" "403"
  log_test P3 "${KALI_IP:-kali}" "http://$SERVER_IP/archive/" "403"
  log_test P4 "${KALI_IP:-kali}" "http://$SERVER_IP/archive/dummy-records.txt" "403"
  ;;
fw-allowed)
  curl -i "http://$SERVER_IP/public/" | tee firewall-allowed.txt
  log_test F1 "${KALI_IP:?export KALI_IP}" "http://$SERVER_IP/public/" "200"
  ;;
fw-blocked)
  : "${IFACE:?export IFACE (check with ip -br addr)}" "${BLOCK_IP:?export BLOCK_IP (unused IP, same subnet)}"
  sudo ip addr add "$BLOCK_IP/24" dev "$IFACE"
  date -Is | tee firewall-blocked-time.txt
  log_test F2 "$BLOCK_IP" "http://$SERVER_IP/public/" "timeout (UFW drop)" --interface "$BLOCK_IP"
  sleep 3
  log_test F3 "$BLOCK_IP" "http://$SERVER_IP/public/" "timeout (UFW drop)" --interface "$BLOCK_IP"
  sudo ip addr del "$BLOCK_IP/24" dev "$IFACE"
  ;;
logs)   # generate the requests you will look for in the Ubuntu logs
  log_test L1 "${KALI_IP:-kali}" "http://$SERVER_IP/public/"  "200 (appears in nginx log)"
  sleep 2
  log_test L2 "${KALI_IP:-kali}" "http://$SERVER_IP/archive/" "403 (appears in nginx log)"
  ;;
recovery-fail)
  curl -i "http://$SERVER_IP/public/" | tee recovery-failed-check.txt
  log_test R1 "${KALI_IP:-kali}" "http://$SERVER_IP/public/" "NOT 200 after deletion"
  ;;
recovery-ok)
  curl -i "http://$SERVER_IP/public/" | tee recovery-restored-check.txt
  log_test R2 "${KALI_IP:-kali}" "http://$SERVER_IP/public/" "200 after restore"
  ;;
*) echo "Usage: $0 baseline|avoidance|archive|fw-allowed|fw-blocked|logs|recovery-fail|recovery-ok"; exit 1;;
esac
