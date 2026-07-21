#!/bin/bash

export HOME=/home/ec2-user

if command -v aws >/dev/null 2>&1; then
    echo "AWS CLI already installed."
else
    echo "Installing AWS CLI..."
    dnf install -y awscli
fi

if curl -fsSL -o /home/ec2-user/backup.sh https://raw.githubusercontent.com/oussamazkr/linux-scripts/main/backup.sh; then
	echo "backup.sh downloaded successfully from GitHub"
	chmod +x /home/ec2-user/backup.sh
	bash /home/ec2-user/backup.sh /etc
	echo 
	
else 
	echo "Failed to download backup.sh from GitHub"
    exit 1
fi
