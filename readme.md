This container runs borgbackup daily.
Everything mapped to /data folder is backed up to /repo .

# run 
docker run \
    -e BACKUP_HOUR=22 \
    -e BORG_PASSPHRASE=my-secret-pw \
    -e TZ=Europe/Berlin \
    -v backup-dir:/repo \
    -v storage:/data/data1 \
    -v private_data:/data/data2 \
    --name borg-backup \
    martinay/borgbackup:latest

# Environment variables:
BACKUP_HOUR = hour when backup is started (default is 23)

used for borg prune:
KEEP_DAILY = 7
KEEP_WEEKLY = 1
KEEP_MONTHLY = 1

# restore
run a temporary docker container and execute borg commands in the opening shell
docker run \
    --rm \
    -it \
    -e BORG_PASSPHRASE=my-secret-pw \
    -e TZ=Europe/Berlin \
    -v backup-dir:/repo \
    -v restore-here:/restore \
    --name borg-backup-restore \
    martinay/borgbackup:latest \
    /bin/sh

# tags
1.1.17, latest -> borg version 1.1.17

# build
docker build -t martinay/borgbackup:latest .