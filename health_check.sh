#!/bin/bash
printf "\n"
printf "=====================================================\n"
printf "              SYSTEM HEALTH REPORT\n"
printf "=====================================================\n\n"
printf "\n"

echo "Hostname: $(hostname)"
printf "\n"
echo "Uptime: $(uptime)"
printf "\n"

echo "-----------------------------------------------------"
echo "Disk Usage:"
echo "-----------------------------------------------------"
df -h /

printf "\n"
echo "-----------------------------------------------------"
echo "Memory Usage"
echo "-----------------------------------------------------"
free -h
printf "\n"

echo "-----------------------------------------------------"
echo "Top 5 processes by memory consumption:"
echo "-----------------------------------------------------"
ps aux --sort=-%mem | head -n 6
printf "\n"

if [ -n "$1" ]; then
	if systemctl list-unit-files | grep -q "^$1\.service"; then
		echo "Service '$1' status is:" $(systemctl is-active "$1")
	else
		echo "'$1' is not a service"
		exit 1
	fi	
fi
exit 0
