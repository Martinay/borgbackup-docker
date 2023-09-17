ARG ALPINE_VERSION
FROM alpine:$ALPINE_VERSION

ARG BORG_VERSION

ENV LANG en_US.UTF-8

RUN apk add --no-cache borgbackup=$BORG_VERSION tzdata

ENV BORG_REPO="/repo" DATA_DIR="/data" LOG_DIR="/logs"

COPY Scripts/startup.sh /
COPY Scripts/backup.sh /etc/periodic/borgbackup/backup

RUN chmod +x startup.sh

CMD [ "./startup.sh" ]