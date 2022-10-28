@echo off

set VERSION=1.2.0
set REPO=martinay/borgbackup

docker build -t %REPO%:%VERSION% -t %REPO%:latest .
docker push %REPO%:%VERSION%
docker push %REPO%:latest
