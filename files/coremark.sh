#!/bin/sh

echo "performance" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor 2>/dev/null
/bin/coremark | tail -n 1 | awk '{printf("(CpuMark : %s Scores)\n",$4)}' > /etc/bench.log
echo "ondemand" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor 2>/dev/null

if [ -f "/etc/bench.log" ]; then
        sed -i '/coremark/d' /etc/crontabs/root
        crontab /etc/crontabs/root
fi
