#!/bin/bash
set -euo pipefail

ZSH_STARTUP_THRESHOLD_MS=200

echo "Measuring zsh startup time (5 runs)..."
total=0
for i in 1 2 3 4 5; do
  ms=$({ /usr/bin/time zsh -i -c exit; } 2>&1 | awk '{printf "%d", $1 * 1000}')
  total=$((total + ms))
  echo "  run $i: ${ms}ms"
done
avg=$((total / 5))
echo "  avg: ${avg}ms (threshold: ${ZSH_STARTUP_THRESHOLD_MS}ms)"
if [ "$avg" -gt "$ZSH_STARTUP_THRESHOLD_MS" ]; then
  echo "WARN: zsh startup is slow (${avg}ms > ${ZSH_STARTUP_THRESHOLD_MS}ms)"
else
  echo "PASS"
fi
