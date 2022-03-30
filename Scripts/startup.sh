#!/bin/sh

if [ -z "${BORG_PASSPHRASE:-}" ]; then
    echo 'env variable $BORG_PASSPHRASE is required'
    exit 1
fi

if [ ! -d $DATA_DIR ]; then
    echo "Data dir is not available. Map folder to $DATA_DIR"
    exit 1
fi

if [ ! -d $BORG_REPO ]; then
    echo "Repo dir is not available. Map folder to $BORG_REPO"
    exit 1
fi

if [ -z "${BACKUP_HOUR:-}" ]; then
    BACKUP_HOUR='23'
    echo 'Backup hour is set to default value 23. If you want to set this use env variable $BACKUP_HOUR'
else
    echo "Backup will start at ${BACKUP_HOUR}"
fi

# If the repo is empty init it
if [ ! "$(ls -A $BORG_REPO)" ]; then
    borg init -v --show-rc --encryption=repokey
fi

# Setup cron schedule
echo "*       $BACKUP_HOUR       *       *       *       run-parts /etc/periodic/borgbackup" >> /etc/crontabs/root

echo "$(date) - done with setup..."
echo "$(date) - waiting until ${BACKUP_HOUR}:00 to start first backup"

crond -f -l 8