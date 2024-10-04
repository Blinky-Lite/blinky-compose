#!/bin/bash
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color
if [ "$#"  -ne 1 ]
then
    echo -e "${RED}Usage: ./runbackup.sh <databasePassword>${NC}"
    exit 1
fi
remoteDirName=$(hostname)-$(date +"%y-%m-%d")
echo -e "${GREEN}Creating backup " $remoteDirName ${NC}
mkdir  $remoteDirName
cd $remoteDirName
echo -e "${GREEN}Creating " $remoteDirName "on Google Drive${NC}"
rclone mkdir google-drive:$remoteDirName
echo -e "${GREEN}Copying blinky-box volumes...${NC}"
docker run --rm --volumes-from blinky-box -v $(pwd):/backup busybox tar cvfz /backup/backup.tar /data/html-static
echo -e "${GREEN}...Finished copying blinky-box volumes${NC}" 
mv backup.tar  blinky-lite_extra-img.tar
echo -e "${GREEN}Copying blinky-lite_mongo-data database...${NC}"
docker exec -i blinky-mongo /usr/bin/mongodump --username admin --password $1 --authenticationDatabase admin --db blinky-lite --archive > mongodb
tar cvfz blinky-lite_mongo-data.tar mongodb
rm mongodb
echo -e "${GREEN}...Finished copying blinky-lite_mongo-data database${NC}" 
echo -e "${GREEN}Exporting to Google Drive...${NC}"
rclone copy . google-drive:$remoteDirName
echo -e "${GREEN}...Finished export to Google Drive${NC}"
echo -e "${GREEN}Finished backup " $remoteDirName ${NC}
