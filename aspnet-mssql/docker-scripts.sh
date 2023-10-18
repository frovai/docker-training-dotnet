#!/bin/bash
# Build image
cd app/aspnetapp
docker build -t web-docker .

### CREATE CONTAINERS

## Create web container
docker run --name web-docker -p 8080:80 -di web-docker 

## Create db container
docker run --name db-docker -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=example_123' -p 1433:1433 -di mcr.microsoft.com/mssql/server

### CREATE NETWORK AND CONNECT CONTAINERS

## Create Network Docker
docker network create docker-network

## Create web container
docker run --name web-docker -p 8080:80 --network docker-network -di web-docker 

## Create db container
docker run --name db-docker -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=example_123' -p 1433:1433  --network docker-network -di mcr.microsoft.com/mssql/server

## Delete containers and images

docker stop web-docker db-docker
docker rm web-docker db-docker
docker rmi web-docker db-docker

### Testing images and CREATE VOLUMES

apt update -y
apt install wget -y
cd wwwroot/images
ls
wget https://coisascriativas.b-cdn.net/wp-content/uploads/2019/09/paisagem-Montanhas-e-lago.jpg
ls
#Acesse abaixo
http://localhost:8080/images/paisagem-Montanhas-e-lago.jpg

#Destrua os containers
docker stop web-docker
docker rm web-docker

#Suba de novo
docker-compose up -d

## List volumes
docker volume ls
sudo ls /var/lib/docker/volumes/aspnet-mssql_web-docker-vol/_data

### Testing images and CREATE VOLUMES

## Best practices Docker 
https://docs.docker.com/develop/develop-images/instructions/


### Testing security issues, scan with Aqua trivy
sudo usermod -aG docker $(whoami)
docker run aquasec/trivy image web-docker

docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker | grep -E 'HIGH|CRITICAL'
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image agr-docusign:crdc| grep -E 'HIGH|CRITICAL'

## Scan with reports in HTML

docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/tmp/.cache/ aquasec/trivy image --format template --template "@contrib/html.tpl" -o /tmp/.cache/docusign-report.html agr-docusign:crdc 
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/tmp/.cache/ aquasec/trivy image --format template --template "@contrib/html.tpl" -o /tmp/.cache/web-docker-report.html web-docker
