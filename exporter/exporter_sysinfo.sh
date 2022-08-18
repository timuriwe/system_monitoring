#!/bin/bash

function get_metrics {
  FreeOutput="$(free -b | grep "Mem:")"
  MemTotal="$(awk '{print $2}' <<<"$FreeOutput")"
  MemUsed="$(awk '{print $3}' <<<"$FreeOutput")"
  MemFree="$(awk '{print $4}' <<<"$FreeOutput")"
  MemShared="$(awk '{print $5}' <<<"$FreeOutput")"
  MemBuffCache="$(awk '{print $6}' <<<"$FreeOutput")"
  MemAvailable="$(awk '{print $7}' <<<"$FreeOutput")"

  DiskTotalOuput="$(df --block-size=KB /)"
  DiskTotal="$(awk 'NR==2{print $2}' <<<"$DiskTotalOuput" | grep -o "[0-9]*")"
  DiskUsed="$(awk 'NR==2{print $3}' <<<"$DiskTotalOuput" | grep -o "[0-9]*")"
  DiskAvailable="$(awk 'NR==2{print $4}' <<<"$DiskTotalOuput" | grep -o "[0-9]*")"

  CpuIdle="$(top -bn1 | awk 'NR==3{print $0}' | sed 's/:/ /' | awk '{print $8}' | sed 's/,/./')"
  CpuUsage="$(awk 'BEGIN {printf "%.1f", 100.0-'"$CpuIdle"'}' | sed 's/,/./')"
}

function get_report {
  record mem_total_bytes "$MemTotal" "Total RAM memory in bytes"
  record mem_used_bytes "$MemUsed" "Used RAM memory in bytes"
  record mem_free_bytes "$MemFree" "Free RAM memory in bytes"
  record mem_shared_bytes "$MemShared" "Shared RAM memory in bytes"
  record mem_buffcache_bytes "$MemBuffCache" "Buff/Cache RAM memory in bytes"
  record mem_available_bytes "$MemAvailable" "Available RAM memory in bytes"

  record disk_total_bytes "$(("$DiskTotal" * 1000))" "Total disk space in bytes"
  record disk_used_bytes "$(("$DiskUsed" * 1000))" "Used disk space in bytes"
  record disk_available_bytes "$(("$DiskAvailable" * 1000))" "Available disk space in bytes"

  record cpu_idle "$CpuIdle" "CPU usage for idle proccess in percentage"
  record cpu_usage "$CpuUsage" "CPU usage in percentage"
}

function record {
  NAME="$1"
  VALUE="$2"
  DESCRIPTION="$3"
  METRIC="gauge"
  echo "# HELP $NAME $DESCRIPTION"
  echo "# TYPE $NAME $METRIC"
  echo "$NAME $VALUE"
}

while true; do
  get_metrics
  get_report >../nginx/html/metrics/metrics.txt
  sleep 10
done
