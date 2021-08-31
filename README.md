## Dockerized cron jobs

1. Colone this repository.
2. Add shell script to execute with cron into `jobs directory (see example)
3. Add setup shell scripts to `jobs_setup` directory.
4. Build image with command: `docker build -t cron-jobs .`
5. To run container with the example job execute command:

```
docker run --name cron-jobs \
	--restart always \
	--detach \
	-e DB_HOSTNAME=host \
	-e DB_PORT=port \
	-e DB_USERNAME=uaser \
	-e DB_DATABASENAME=dbname \
	-e RUN_PG_BACKUP_CRON_EXP="0 12 * * *"
	-e BACKUP_DIR="/etc/aispwd-bak"
	-v $PWD/backups:/etc/aispwd-bak \
	-v $PWD/secrets:/root/ \
	cron-jobs:latest
```
