FROM eclipse-mosquitto:2.0.15
#COPY mosquitto.conf       /mosquitto/config
COPY initMqtt.sh /
RUN  chmod +x /initMqtt.sh
CMD /initMqtt.sh
