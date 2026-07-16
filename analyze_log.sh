#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Usage: ./analyze_log.sh <logfile>"
	exit 1
fi

if [ ! -f "$1" ]; then
	echo "Error: Please enter a valid file"
	exit 1
fi

if [ ! -r "$1" ]; then
	echo "File is not readable, access denied"
	exit 1
fi

echo "Number of lines: $(wc -l < "$1")" 

echo "Number of warnings: $(grep -ic "warn" "$1")"


echo "Number of errors: $(grep -ic "error" "$1")"


echo "Number of fails: $(grep -ic "fail" "$1")"

echo "Top 5 most frequent lines:"

grep . "$1" | sort | uniq -c | sort -rh | head -5
exit 0
