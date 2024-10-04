#!/bin/bash
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color
if [ "$#"  -ne 2 ]
then
    echo -e "${RED}Usage: ./restorebackup.sh <backupName> <databasePassword>${NC}"
    exit 1
fi
echo -e "${GREEN}Restore backup " $1 ${NC}
echo -e "${GREEN}Recalling " $1 "on Google Drive${NC}"
rclone copy  google-drive:$1 $1
cd $1
echo -e "${GREEN}Restoring blinky-box volumes...${NC}"
docker run --rm --volumes-from blinky-box -v $(pwd):/backup busybox sh -c "cd /data && tar xvfz /backup/blinky-lite_extra-img.tar --strip 1"
echo -e "${GREEN}...Finished restoring blinky-box volumes${NC}" 
echo -e "${GREEN}Restoring blinky-mongo database...${NC}"
tar xvfz blinky-lite_mongo-data.tar
docker exec -i blinky-mongo /usr/bin/mongorestore --username admin --password $2 --authenticationDatabase admin --nsInclude="blinky-lite.*" --archive < mongodb
rm mongodb
echo -e "${GREEN}...Finished restoring blinky-lite_mongo-data database${NC}" 
