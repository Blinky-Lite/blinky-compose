#!/bin/bash
portainerIde=$(sudo docker container ls -a -q --filter "name=portainer")
portainerIdr=$(sudo docker container ls -q --filter "name=portainer")
if [ $(expr length "$portainerIde") -gt 10 ]
then
    echo "portainer exists"
    if [ $(expr length "$portainerIdr") -gt 10 ]
    then
        echo "portainer running"
        echo "exiting script"
    else
        echo "restarting portainer"
        sudo docker container start $portainerIde
        echo "exiting script"
    fi
else
    if [ $(expr length "$1") -gt 11 ]
    then
        echo "Creating portainer"
            pw=$(htpasswd -bnBC 10 "" $1 | tr -d ':\n')
            sudo docker run -d -p 8000:8000 -p 9000:9000 --name portainer --network tunnel --restart=unless-stopped \
                -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest \
                --admin-password=$pw --http-enabled \
                --logo https://raw.githubusercontent.com/Blinky-Lite/blinky-compose/main/images/BlinkyLogoName.png        
            echo "exiting script"
    else
        echo "Password must be at least 12 characters long"
        echo "PORTAINER NOT STARTED!"
        echo "exiting script"
    fi
fi

