# CloudMarkdown
## Build
```
sudo docker build -t cloudmd:1.0 .
sudo docker run -p 8083:8083 --name cloudmd -dit cloudmd:1.0
sudo docker ps -a
sudo docker exec -it cloudmd /bin/bash
sudo docker stop cloudmd && sudo docker rm cloudmd
```

```
sudo docker build -t cloudmd:1.0 .
sudo docker run -p 8083:8083 --name cloudmd -dit cloudmd:1.0 npm run --prefix /home/cloudmd/cloudmd-back/ server 8083
```