#!/bin/bash

# Set variables
BACKUP_DIR="/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
DB_NAME="sme_deans_repo_db"
DB_USER="postgres"
DB_PASSWORD="admin123"
DB_HOST="db"
DB_PORT="5432"

# Set PGPASSWORD environment variable
export PGPASSWORD="${DB_PASSWORD}"

# Create backup
echo "[$(date)] Starting backup..."
pg_dump -h ${DB_HOST} -U ${DB_USER} -d ${DB_NAME} -p ${DB_PORT} > ${BACKUP_DIR}/backup_${TIMESTAMP}.sql

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "[$(date)] Backup completed successfully: backup_${TIMESTAMP}.sql"
else
    echo "[$(date)] Backup failed!"
fi

# Unset PGPASSWORD for security
unset PGPASSWORD 