#!/bin/bash

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
docker run --rm --volumes-from blinky-mongo -v $(pwd):/backup busybox tar cvfz /backup/backup.tar /data/db
echo "...Finished copying blinky-lite_mongo-data database" 
mv backup.tar  blinky-lite_mongo-data.tar
echo "Exporting to Google Drive..."
rclone copy . google-drive:$remoteDirName
echo "...Finished export to Google Drive"
echo "Finished backup " $remoteDirName
