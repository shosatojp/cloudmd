IMAGE=cloudmd:1.0
CONTAINER=cloudmd

all:
	-sudo docker stop $(CONTAINER)
	-sudo docker rm $(CONTAINER)
	-sudo docker rmi $(CONTAINER)
	sudo docker build -t $(IMAGE) .
	make run
	
run:
	-sudo docker stop $(CONTAINER)
	-sudo docker rm $(CONTAINER)
	sudo docker run -p 8083:8083 --name $(CONTAINER) -dit $(IMAGE) npm run --prefix /home/cloudmd/cloudmd-back/ server 8083


clean:
	-sudo docker rmi `sudo docker images -f "dangling=true" -q`
	-sudo docker rm `sudo docker ps -qaf status=exited`