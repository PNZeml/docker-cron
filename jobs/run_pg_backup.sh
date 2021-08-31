#! /bin/sh

BACKUP_DEFAULT_DIR="/etc/aispwd-bak"

[ -z "$BACKUP_DIR" ] \
    && backupDir="$BACKUP_DEFAULT_DIR" \
    || echo backupDir="$BACKUP_DIR"

# Enusre that backup directory exists
mkdir -p $backupDir

# Ensure thath pgpass has right permissions
chmod 0600 ~/.pgpass

dumpFile="backup_""$(date +%s)"".sql"
echo "Start writing backup into ""$dumpFile"

if pg_dump \
    --host=$DB_HOSTNAME \
    --port=$DB_PORT \
    --username=$DB_USERNAME \
    --dbname=$DB_DATABASENAME \
    -w > $backupDir/$dumpFile; then
    echo "Backup has been successful"
else
    echo "Backup has been failed"
fi
