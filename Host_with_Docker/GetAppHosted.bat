docker network create -d ics --subnet 172.10.0.0/16 --gateway 172.10.5.254 hostsubnet
TIMEOUT /t 10
docker-compose up -d
ECHO "Process Completed"
pause...