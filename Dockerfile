FROM alpine:latest AS host

# Cron env variabels
ENV CRON_JOBS_DIR="/var/spool/cron/"
ENV CRON_LOG_FILE="/var/log/cron.log"

# Job scripts env variabels
ENV SCRIPTS_SETUP_DIR="/opt/cron_scripts_setup/"
COPY $PWD/jobs_setup/*.sh $SCRIPTS_SETUP_DIR

ENV SCRIPTS_DIR="/opt/cron_scripts/"
COPY $PWD/jobs/*.sh $SCRIPTS_DIR

COPY $PWD/shell/*.sh /
RUN chmod +x /*.sh

# ENTRYPOINT ["/entrypoint.sh"]
CMD /setup_cron.sh && /startup.sh