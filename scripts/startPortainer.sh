#!/bin/bash
docker run -d -p 8000:8000 -p 9000:9000 --name portainer --network tunnel --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest --admin-password='$2a$12$mc3F1cMxAUhcZFdcgQp.bOKfYodTqvl4Ec/f1s5SmCgPGz/ShC7Be' --http-enabled --logo https://raw.githubusercontent.com/Blinky-Lite/blinky-compose/main/images/BlinkyLogoName.png

