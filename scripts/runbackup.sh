#!/bin/bash
if [ "$#"  -ne 1 ]
then
    echo "Usage: ./runbackup.sh <databasePassword>"
    exit 1
fi
remoteDirName=$(hostname)-$(date +"%y-%m-%d")
echo "Creating backup " $remoteDirName
mkdir  $remoteDirName
cd $remoteDirName
echo "Creating " $remoteDirName "on Google Drive"
rclone mkdir google-drive:$remoteDirName
echo "Copying blinky-lite_extra-img database..."
docker run --rm --volumes-from extra-img -v $(pwd):/backup busybox tar cvfz /backup/backup.tar /data/html-static
echo "...Finished copying blinky-lite_extra-img database" 
mv backup.tar  blinky-lite_extra-img.tar
echo "Copying blinky-lite_mongo-data database..."
docker exec -i blinky-mongo /usr/bin/mongodump --username admin --password $1 --authenticationDatabase admin --db blinky-lite --archive > mongodb
tar cvfz blinky-lite_mongo-data.tar mongodb
rm mongodb
echo "...Finished copying blinky-lite_mongo-data database" 
echo "Exporting to Google Drive..."
rclone copy . google-drive:$remoteDirName
echo "...Finished export to Google Drive"
echo "Finished backup " $remoteDirName
