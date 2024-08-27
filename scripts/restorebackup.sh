#!/bin/bash
if [ "$#"  -ne 2 ]
then
    echo "Usage: ./restorebackup.sh <backupName> <databasePassword>"
    exit 1
fi
echo "Restore backup " $1
echo "Recalling " $1 "on Google Drive"
rclone copy  google-drive:$1 $1
cd $1
echo "Restoring blinky-lite_extra-img database..."
docker run --rm --volumes-from extra-img -v $(pwd):/backup busybox sh -c "cd /data && tar xvfz /backup/blinky-lite_extra-img.tar --strip 1"
echo "...Finished restoring blinky-lite_extra-img database" 
echo "Restoring blinky-mongo database..."
tar xvfz blinky-lite_mongo-data.tar
docker exec -i blinky-mongo /usr/bin/mongorestore --username admin --password $2 --authenticationDatabase admin --nsInclude="blinky-lite.*" --archive < mongodb
rm mongodb
echo "...Finished restorign blinky-lite_mongo-data database" 
