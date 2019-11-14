# CloudMarkdown
## Build
```
sudo docker build -t cloudmd:1.0 .
sudo docker run -p 8084:8084 --name cloudmd -dit cloudmd:1.0
sudo docker ps -a
sudo docker exec -it cloudmd /bin/bash
sudo docker stop cloudmd && sudo docker rm cloudmd
```