#!/bin/bash
# System Health Report Script
# Checks disk, RAM, CPU and services

DATE=$(date '+%Y-%m-%d %H:%M:%S')
LOG="logs/health-report.log"

echo "================================="
echo "   System Health Report"
echo "   $DATE"
echo "================================="

# ── DISK CHECK ──
DISK=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
echo ""
echo "DISK USAGE:"
if [ $DISK -gt 80 ]; then
    echo "  WARNING: Disk is at $DISK%"
else
    echo "  OK: Disk is at $DISK%"
fi

# ── RAM CHECK ──
RAM_FREE=$(free -h | grep Mem | awk '{print $4}')
RAM_USED=$(free | grep Mem | awk '{print $3}')
RAM_TOTAL=$(free | grep Mem | awk '{print $2}')
RAM_PERCENT=$((RAM_USED * 100 / RAM_TOTAL))
echo ""
echo "RAM USAGE:"
if [ $RAM_PERCENT -gt 80 ]; then
    echo "  WARNING: RAM used at $RAM_PERCENT% — Free: $RAM_FREE"
else
    echo "  OK: RAM used at $RAM_PERCENT% — Free: $RAM_FREE"
fi

# ── SERVICE CHECK USING LOOP ──
echo ""
echo "SERVICES:"
SERVICES=("nginx" "cron" "systemd-resolved")
for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet $SERVICE; then
        echo "  OK: $SERVICE is RUNNING"
    else
        echo "  FAIL: $SERVICE is DOWN"
    fi
done

# ── SAVE TO LOG ──
echo "================================="
echo "Report saved to: $LOG"
echo "================================="
echo "[$DATE] Disk: $DISK% | RAM: $RAM_PERCENT% | Services checked: ${#SERVICES[@]}" >> $LOG
