FROM alpine:3.16

ENV LANG en_US.UTF-8

RUN apk add --no-cache borgbackup=1.2.0-r0 tzdata

ENV BORG_REPO="/repo" DATA_DIR="/data" LOG_DIR="/logs"

COPY Scripts/startup.sh /
COPY Scripts/backup.sh /etc/periodic/borgbackup/backup

RUN chmod +x startup.sh

CMD [ "./startup.sh" ]