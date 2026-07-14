#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Usage: ./backup.sh <directory>"
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "Please enter a valid directory"
	exit 1
fi 

echo "starting backup for '$1'"

# variables

file_name=$(basename "$1")
time_stamp=$(date "+%F_%H-%M-%S")
backup_name="${file_name}_${time_stamp}.tar.gz"
backup_path=$HOME/backups/"$backup_name"

mkdir -p ~/backups

if tar -czf "$backup_path" "$1"; then
	echo "Backup created successfully, Find in $backup_path"
	echo "size:"
	du -sh "$backup_path" | cut -f1
	exit 0
else 	
	echo "Failed to backup directory"
	rm -f "$backup_path"
	exit 1
fi

