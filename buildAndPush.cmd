@echo off

set VERSION=1.1.17
set REPO=martinay/borgbackup

docker build -t %REPO%:%VERSION% -t %REPO%:latest .
docker push %REPO%:%VERSION%
docker push %REPO%:latest