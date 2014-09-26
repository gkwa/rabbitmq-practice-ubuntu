lib=./docker-taylor-config/dockerfiles

Dockerfiles: server/Dockerfile
Dockerfiles: client/Dockerfile

hostip=$(shell curl ifconfig.me)

server/Dockerfile: $(lib)/*.m4
	mkdir -p $(dir $@)
	m4 -I $(lib) Dockerfile.rabbitmq.server.m4 >$@

client/Dockerfile: $(lib)/*.m4
	mkdir -p $(dir $@)
	m4 -I $(lib) Dockerfile.rabbitmq.client.m4 >$@

ctest:
	python client.py

start-server: server/Dockerfile
	sudo docker build --tag=rabbitmqserver $(dir $<)
	sudo docker run -d -p 5672:5672 -p 15672:15672 rabbitmqserver

start-client: client/Dockerfile
	sudo docker build --tag=rabbitmqclient $(dir $<)
	sudo docker run -e serverip=$(hostip) -t rabbitmqclient python /rabbitmq-practice-ubuntu/client.py

clean:
	rm -rf server
	rm -rf client

.PHONY: server
.PHONY: client
