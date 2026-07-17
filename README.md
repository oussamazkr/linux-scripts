# Linux Scripts

## backup.sh
Creates a timestamped, compressed tar.gz backup of a given directory.

Usage: ./backup.sh <directory>

## analyze_log.sh
Analyzes log file for errors, warnings, failures and prints the 5 most re-accuring messages.
Limitations: Error counts include the message 'no errors found', so counts are approximate.

Usage: ./analyze_log <logfile>

## health_check.sh
Checks system health by displaying CPU, memory, disk usage, uptime, and the top memory-consuming processes.
Optionally verifies the status of a specified systemd

Usage ./healch_check.sh [service]
