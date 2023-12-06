FROM nginx:latest
USER root
RUN apt-get update
RUN apt-get install -y nano 
COPY proxconf.sh    /proxconf.sh
COPY base-nginx-init.conf    /etc/nginx/conf.d/nginx-init.conf
RUN rm /etc/nginx/conf.d/default.conf
RUN chmod +x /proxconf.sh

