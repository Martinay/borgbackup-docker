This container runs borgbackup daily.
Everything mapped to /data folder is backed up to /repo .

# run
```
docker run \
    -e BACKUP_HOUR=22 \
    -e BORG_PASSPHRASE=my-secret-pw \
    -e TZ=Europe/Berlin \
    -v backup-dir:/repo \
    -v storage:/data/data1 \
    -v private_data:/data/data2 \
    -v logs:/logs \
    --name borg-backup \
    martinay/borgbackup:latest
```

# Environment variables:
```
BACKUP_HOUR = hour when backup is started (default is 23)
TZ= Timezone e.g. Europe/Berlin
```
used for borg prune:
```
KEEP_DAILY = 7
KEEP_WEEKLY = 1
KEEP_MONTHLY = 1
```
# restore
run a temporary docker container and execute borg commands in the opening shell
```
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
```

# tags
1.2.0, latest -> borg version 1.2.0

# build
docker build -t martinay/borgbackup:latest .

# upgrade guide
## 1.1.17 -> 1.2.0
1. Update image tag and run container
2. Connect to container 'docker exec -it <Id of container> /bin/sh'
3. Run 'borg compact --cleanup-commits --progress --verbose /repo'
4. Exit the container with 'exit'
