#!/bin/sh
ARCHIVE="$(date +%Y-%m-%d)"
echo "starting with backup $(date)"

borg create -v --stats --show-rc -C zlib,6 ::"$ARCHIVE" $BORG_REPO

if [ -z "${KEEP_DAILY:-}" ]; then
    KEEP_DAILY=7
fi
if [ -z "${KEEP_WEEKLY:-}" ]; then
    KEEP_WEEKLY=1
fi
if [ -z "${KEEP_MONTHLY:-}" ]; then
    KEEP_MONTHLY=1
fi

echo "Starting with pruning the repo .... daily: $KEEP_DAILY weekly: $KEEP_WEEKLY monthly: $KEEP_MONTHLY"
borg prune -v --stats --show-rc --keep-daily=$KEEP_DAILY --keep-weekly=$KEEP_WEEKLY --keep-monthly=$KEEP_MONTHLY
