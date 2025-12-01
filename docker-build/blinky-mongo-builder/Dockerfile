FROM mongo:4.4.18-focal
COPY mongodb      /dump/
COPY mongorestore.sh                 /docker-entrypoint-initdb.d
EXPOSE 27017
