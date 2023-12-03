FROM nginx:latest
USER root
RUN apt-get update
RUN apt-get install -y nano 
COPY proxconf.sh    /proxconf.sh
RUN chmod +x /proxconf.sh

