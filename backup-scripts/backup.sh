#!/bin/bash
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="/backups"
POSTGRES_DB=${POSTGRES_DB:-deans_cms}
POSTGRES_USER=${POSTGRES_USER:-postgres}

# Ensure backup directory exists
mkdir -p ${BACKUP_DIR}

# Create backup
pg_dump -h db -U ${POSTGRES_USER} -d ${POSTGRES_DB} > ${BACKUP_DIR}/backup_${TIMESTAMP}.sql

# Compress backup
gzip ${BACKUP_DIR}/backup_${TIMESTAMP}.sql

# Retain only last 7 days of backups
find ${BACKUP_DIR} -type f -mtime +7 -name '*.sql.gz' -delete

# Log backup completion
echo "Backup completed: backup_${TIMESTAMP}.sql.gz" >> ${BACKUP_DIR}/backup.log 