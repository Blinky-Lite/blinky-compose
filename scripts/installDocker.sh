#!/bin/bash
if [ $(expr length "$1") -lt 12 ]
then
    echo "Password must be at least 12 characters long"
    echo "Docker not installed!"
    echo "exiting script"
    exit 1
fi
# Add Docker's official GPG key:
sudo echo 'Installing Docker....'
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#sudo usermod -aG docker $USER
sudo docker network create tunnel 
sudo apt install apache2-utils 
wget https://github.com/Blinky-Lite/blinky-compose/raw/main/scripts/startPortainer.sh
chmod +x startPortainer.sh 
./startPortainer.sh $1
echo '....Finished installing docker...exit terminal and login again' 

