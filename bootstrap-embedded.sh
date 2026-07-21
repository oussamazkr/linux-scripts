#!/bin/bash

export HOME=/home/ec2-user

if command -v aws >/dev/null 2>&1; then
    echo "AWS CLI already installed."
else
    echo "Installing AWS CLI..."
    dnf install -y awscli
fi

cat > /home/ec2-user/backup.sh << 'EOF'
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

mkdir -p $HOME/backups

if tar -czf "$backup_path" "$1"; then
        echo "Backup created successfully, Find in $backup_path"
        echo "size:"
        du -sh "$backup_path" | cut -f1
        if aws s3 cp "$backup_path" s3://oussamazkr-ec2-backups-2026/; then
                echo "Backup Uploaded successfully"
        else
                echo "Upload failed — backup kept locally at $backup_path"
                exit 1
        fi
        exit 0
else
        echo "Failed to backup directory"
        rm -f "$backup_path"
        exit 1
fi
EOF

chmod +x /home/ec2-user/backup.sh

/home/ec2-user/backup.sh /etc
