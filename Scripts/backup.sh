#!/bin/sh
ARCHIVE="$(date +%Y-%m-%d)"

LOG_PATH="$LOG_DIR/$ARCHIVE.log"
mkdir -p $LOG_DIR

echo "starting $(date)" 2>&1 | tee -a $LOG_PATH
echo "cleaning logs" 2>&1 | tee -a $LOG_PATH
find $LOG_DIR -type f -mtime +30 -delete 2>&1 | tee -a $LOG_PATH


echo "start backup" 2>&1 | tee -a $LOG_PATH
borg create -v --stats --show-rc -C zlib,6 ::"$ARCHIVE" $DATA_DIR 2>&1 | tee -a $LOG_PATH

if [ -z "${KEEP_DAILY:-}" ]; then
    KEEP_DAILY=7
fi
if [ -z "${KEEP_WEEKLY:-}" ]; then
    KEEP_WEEKLY=1
fi
if [ -z "${KEEP_MONTHLY:-}" ]; then
    KEEP_MONTHLY=1
fi

echo "Starting with pruning the repo .... daily: $KEEP_DAILY weekly: $KEEP_WEEKLY monthly: $KEEP_MONTHLY" 2>&1 | tee -a $LOG_PATH
borg prune -v --stats --show-rc --keep-daily=$KEEP_DAILY --keep-weekly=$KEEP_WEEKLY --keep-monthly=$KEEP_MONTHLY 2>&1 | tee -a $LOG_PATH
