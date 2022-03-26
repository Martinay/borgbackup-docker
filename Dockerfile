FROM alpine:3.15

ENV LANG en_US.UTF-8

RUN apk add --no-cache borgbackup=1.1.17-r2 tzdata

ENV BORG_REPO="/repo" DATA_DIR="/data"

COPY Scripts/startup.sh /
COPY Scripts/backup.sh /etc/periodic/borgbackup/backup

CMD [ "./startup.sh" ]