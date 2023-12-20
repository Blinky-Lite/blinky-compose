#!/bin/ash
set -e
echo "Blinky-MQTT: executing entrypoint script"
# Set permissions
user="$(id -u)"
if [ "$user" = '0' ]; then
	[ -d "/mosquitto" ] && chown -R mosquitto:mosquitto /mosquitto || true
fi

touch /aclfile
echo "user $BOX" > /aclfile
echo "topic readwrite $BOX/#" >> /aclfile
echo "topic readwrite +/$HUB/#" >> /aclfile

touch /mosquitto.conf
echo "allow_anonymous false" > /mosquitto.conf
echo "password_file /pwfile" >> /mosquitto.conf
echo "acl_file /aclfile" >> /mosquitto.conf
echo "listener 1883 0.0.0.0" >> /mosquitto.conf
echo "log_dest none" >> /mosquitto.conf
if [ "$REMOTE_MQTTSERVER" != "none" ];  then
  echo "connection bridge-01" >> /mosquitto.conf
  echo "try_private true" >> /mosquitto.conf
  echo "remote_username $REMOTE_MQTTUSER" >> /mosquitto.conf
  echo "remote_password $REMOTE_MQTTPASSWORD" >> /mosquitto.conf
  echo "address $REMOTE_MQTTSERVER:1883" >> /mosquitto.conf
  echo "topic $BOX/$HUB/# both 0" >> /mosquitto.conf
  if [ "$EXTRA_HUB_TOPIC1" != "none" ];  then
    echo "topic $EXTRA_HUB_TOPIC1/$HUB/# both 0" >> /mosquitto.conf
  fi
  if [ "$EXTRA_HUB_TOPIC2" != "none" ];  then
    echo "topic $EXTRA_HUB_TOPIC2/$HUB/# both 0" >> /mosquitto.conf
  fi
fi  

touch /pwfile
mosquitto_passwd -b /pwfile $BOX $BLINKYLITE_PASSWORD

/usr/sbin/mosquitto -c /mosquitto.conf

exit 0



