#!/bin/bash

# Set variables
BACKUP_DIR="/backups"

# Check latest backup
latest_backup=$(ls -t ${BACKUP_DIR}/backup_*.sql 2>/dev/null | head -n1)

if [ -z "$latest_backup" ]; then
    echo "[$(date)] No backups found!"
    exit 1
fi

# Get backup age in minutes
backup_time=$(stat -c %Y "$latest_backup")
current_time=$(date +%s)
backup_age=$(( (current_time - backup_time) / 60 ))

echo "[$(date)] Latest backup: $latest_backup (${backup_age} minutes old)"

# Alert if backup is too old (more than 7 hours)
if [ $backup_age -gt 420 ]; then
    echo "[$(date)] WARNING: Latest backup is more than 7 hours old!"
    exit 1
fi

exit 0 