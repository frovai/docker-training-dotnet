# Docker hands-on with .Net Application
This reposiroty was created to train people running Docker containers for .Net application , helping understand the using of Dockerfile, docker-compose and to teach some best practices for creating a Docker container and applying Security on your Docker containers

## Dockerfile

Dockerfile is a file that you need to create to design or create you docker image.

## Docker-compose

Docker-compose is another feature of Docker to simply document and create your Docker environment without having to decorate docker commands, you create your docker environments in a more performatic way as well.

### Docker commands

**Create an image web-docker**

In your repository root directory, use this commands to join the folder and create an docker image called **"web-docker"**

```
cd app/aspnetapp
docker build -t web-docker .
```

**Create a container web-docker**

The commands bellow creates/runs a container from the image "web-docker" , named your container as "web-docker" , the "-p" exposes the port 8080 on your host and the "80" inside your container, the "-di" is a flag to make the container runs as a daemon process an make it interactable.
```
docker run --name web-docker -p 8080:80 -di web-docker 
```

**Create a container db-docker**

The commands bellow creates/runs a container from the image "mcr.microsoft.com/mssql/server", named your container as "db-docker" , the "-e" exposes environments 'ACCEPT_EULA' and 'SA_PASSWORD' with your respective values, the "-p" exposes the port "1433" on your host and the "1433" inside your container the "-di" is a flag to make the container runs as a daemon process an make it interactable.
```
docker run --name db-docker -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=example_123' -p 1433:1433 -di mcr.microsoft.com/mssql/server
```

**Create Docker Network docker-network**

The command bellow create a docker network called **"docker-network"**

```
docker network create docker-network
```

**Create a container web-docker using docker-network**

The "--network docker-network" attaches the container "web-docker" to docker network "docker-network".

```
docker run --name web-docker -p 8080:80 --network docker-network -di web-docker 
```

**Create a container db-docker using docker-network**

The "--network docker-network" attaches the container "db-docker" to docker network "docker-network".

```
docker run --name db-docker -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=example_123' -p 1433:1433  --network docker-network -di mcr.microsoft.com/mssql/server
```
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

# Build vulnerable image to compare
docker build -t web-docker-vulnerable -f Dockerfile-bkp .
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/tmp/.cache/ aquasec/trivy image --format template --template "@contrib/html.tpl" -o /tmp/.cache/web-docker-vulnerable-report.html web-docker-vulnerable
