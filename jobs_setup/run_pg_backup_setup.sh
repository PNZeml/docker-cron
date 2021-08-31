#! /bin/sh

JOB_NAME="run_pg_backup"
RUN_PG_BACKUP_DEFAULT_CRON_EXP="* * * * *"

jobFile="$CRON_JOBS_DIR""/""$JOB_NAME"
jobScriptFile="$SCRIPTS_DIR""/""$JOB_NAME"".sh"

[ -z "$RUN_PG_BACKUP_CRON_EXP" ] \
    && cronExp="$RUN_PG_BACKUP_DEFAULT_CRON_EXP" \
    || echo cronExp="$RUN_PG_BACKUP_CRON_EXP"

# Setup necessary tools
echo "Setup postgresql client"
if apk add postgresql-client; then
    echo "Postgresql client setuped successfull"
else
    echo "Failed to setup postgresql client"
    return
fi

# Enshure thath script has an execution permission
chmod +x "$jobScriptFile"

# Create cron job file
echo -e "$cronExp" "$jobScriptFile" ">" "/proc/1/fd/1 2>/proc/1/fd/2" "| tee" "$CRON_LOG_FILE" "\n" > "$jobFile"

# Ensure that job file has right permissions
chmod 0644 $jobFile

# Apply cron job
crontab $jobFile
