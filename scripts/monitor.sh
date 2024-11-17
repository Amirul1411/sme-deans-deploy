#!/bin/bash

LOG_FILE="/backups/monitor.log"
BACKUP_DIR="/backups"

# Get the latest backup file
latest_backup=$(ls -t ${BACKUP_DIR}/backup_*.sql.gz 2>/dev/null | head -n1)

if [ -z "$latest_backup" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR - No backups found" >> $LOG_FILE
    exit 1
fi

# Check if the latest backup is less than 24 hours old
backup_time=$(stat -c %Y "$latest_backup")
current_time=$(date +%s)
age_hours=$(( ($current_time - $backup_time) / 3600 ))

if [ $age_hours -lt 24 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - INFO - Backup check passed. Latest backup: $(basename $latest_backup)" >> $LOG_FILE
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING - Latest backup is more than 24 hours old: $(basename $latest_backup)" >> $LOG_FILE
fi 