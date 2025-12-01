#!/bin/bash
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color
if [ "$#"  -ne 1 ]
then
    echo -e "${RED}Usage: ./getDbArchive.sh <databasePassword>${NC}"
    exit 1
fi
echo -e "${GREEN}Copying blinky-lite_mongo-data database...${NC}"
docker exec -i blinky-mongo /usr/bin/mongodump --username admin --password $1 --authenticationDatabase admin --db blinky-lite --archive > mongodb
echo -e "${GREEN}Finished writing archive mongodb" 
