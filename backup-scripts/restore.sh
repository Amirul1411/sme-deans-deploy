#!/bin/bash
BACKUP_FILE=$1
POSTGRES_DB=${POSTGRES_DB:-deans_cms}
POSTGRES_USER=${POSTGRES_USER:-postgres}

if [ -z "$BACKUP_FILE" ]; then
    echo "Please specify backup file"
    exit 1
fi

# If file is compressed, decompress it
if [[ $BACKUP_FILE == *.gz ]]; then
    gunzip -c ${BACKUP_FILE} | psql -h db -U ${POSTGRES_USER} -d ${POSTGRES_DB}
else
    psql -h db -U ${POSTGRES_USER} -d ${POSTGRES_DB} < ${BACKUP_FILE}
fi 