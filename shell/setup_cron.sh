#!/bin/sh

CRON_LOG_DEFAULT_FILE="/var/log/cron.log"

[ -z "$CRON_LOG_FILE" ] \
    && CRON_LOG_FILE="$CRON_LOG_DEFAULT_FILE"

touch $CRON_LOG_FILE

for setupFile in $SCRIPTS_SETUP_DIR/*
do
    chmod +x $setupFile
    echo $setupFile
    if sh $setupFile; then
        echo "Setup ""$setupFile"" successfully"
    else
        echo "Failed to execute ""$setupFile"
    fi
done
