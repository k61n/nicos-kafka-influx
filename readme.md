The main purpose is to test alternative NICOS cache backends, such as Kafka and InfluxDB.

NICOS repo is checked out during the build of the image. However, optionally user can
mount his local NICOS repo to the container. For that a to docker-compose.yml should be
changed in the following lines:

```
#    volumes:
#      - /optional/path/to/local/nicos:/home/nicos/nicos
```
