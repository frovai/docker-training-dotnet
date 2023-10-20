# Docker hands-on with .Net Application
This reposiroty was created to train people running Docker containers for .Net application , helping understand the using of Dockerfile, docker-compose and to teach some best practices for creating a Docker container and applying Security on your Docker containers

## Docker advantages

* **Speed, Rapid application deployment** – Containers include the minimal runtime requirements of the application, reducing their size and allowing them to be deployed quickly.
* **Imutability** - Immutable means that a container won't be modified during its life: no updates, no patches, no configuration changes. If you must update the application code or apply a patch, you build a new image and redeploy it. Immutability makes deployments safer and more repeatable.
* **Scalability** - Is easy and fast to scale you application from one to thousands in seconds.
* **Disposability** - Docker can be started or stopped at any time. This facilitates elastic scaling, rapid deployment of code or configuration changes, and robustness of production deployments.
* **Isolation** - The container runs in a namespaced concept, so this makes it harder for malicious container workloads to escape the container and infect the Host or other containers. Isolation makes it's easy to debug problems or solve bugs as well because it will be isolated from other applications.
* **Portability across machines** – an application and all its dependencies can be bundled into a single container that is independent from the host version of Linux kernel, platform distribution, or deployment model. This container can be transfered to another machine that runs Docker, and executed there without compatibility issues.
* **Version control and component reuse** – you can track successive versions of a container, inspect differences, or roll-back to previous versions. * Containers reuse components from the preceding layers, which makes them noticeably lightweight.
* **Sharing** – you can use a remote repository ( docker registry ) to share your container with others.
* **Lightweight footprint and minimal overhead** – Docker images are typically very small, which facilitates rapid delivery and reduces the time to deploy new application containers. Docker’s lightweight nature ensures that resources are optimally utilized, thereby reducing overheads and boosting performance.
* **Simplified maintenance** – Docker reduces effort and risk of problems with application dependencies.

## Dockerfile

Dockerfile is a file that you need to create to design or create you docker image.

## Docker-compose

Docker-compose is another feature of Docker to simply document and create your Docker environment without having to decorate docker commands, you create your docker environments in a more performatic way as well.

### **Docker commands**

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

**Stop and Delete containers and images**

```
docker stop web-docker db-docker
docker rm web-docker db-docker
docker rmi web-docker db-docker
```

**Docker-compose create stack**

Create your file called "docker-compose.yml" and run the all the commands bellow inside the folder where is the file

```
docker-compose up -d
```

**Docker-compose destroy the stack**

```
docker-compose down -d
```

**Docker-compose build the stack**

```
docker-compose build
```

**Testing containers using volumes**

The commands bellow join the container web-docker, update packages, install wget and download an image for the "image" folder of web-docker .Net application.

```
docker run -it web-docker sh
apt update -y
apt install wget -y
cd wwwroot/images
ls
wget https://coisascriativas.b-cdn.net/wp-content/uploads/2019/09/paisagem-Montanhas-e-lago.jpg
ls
exit
```

Test the access to this image downloaded inside the container accessing the browser on the link bellow:


[http://localhost:8080/images/paisagem-Montanhas-e-lago.jpg](http://localhost:8080/images/paisagem-Montanhas-e-lago.jpg)

**Everything is WORKING!**

Now stop and destroy the container web-docker:

```
docker stop web-docker
docker rm web-docker
```

Run the command **"docker-compose up -d"** again and verify if the image still exists inside the **"wwwroot/images"** folder inside the container web-docker:

[http://localhost:8080/images/paisagem-Montanhas-e-lago.jpg](http://localhost:8080/images/paisagem-Montanhas-e-lago.jpg)

**IT WON'T**

After that, uncomment the lines bellow, inside the file **"docker-compose.yml"** and re-run the command to create the stack.

This lines will create a volume called **"web-docker-vol"** and attach this volume inside the service/docker **"web-docker"**, on the folder **"/app/wwwroot/images"**
```
    #volumes:
    #  - web-docker-vol:/app/wwwroot/images
#volumes:
#  web-docker-vol:      
```

```
docker-compose up -d
```

Now make the same process again, join inside the "web-docker" container, download the same image with the command bellow

```
docker run -it web-docker sh
apt update -y
apt install wget -y
cd wwwroot/images
wget https://coisascriativas.b-cdn.net/wp-content/uploads/2019/09/paisagem-Montanhas-e-lago.jpg
exit
```

Test again:

[http://localhost:8080/images/paisagem-Montanhas-e-lago.jpg](http://localhost:8080/images/paisagem-Montanhas-e-lago.jpg)

**Everything is WORKING!**

Now the images are kept inside the host and not only inside the container. 
If you want to know where this volumes are created on docker and inside the host, run the commands bellow:

```
docker volume ls
sudo ls /var/lib/docker/volumes/
```

## Best practices Docker 

[Docker best practices](https://docs.docker.com/develop/develop-images/instructions/)

It was created the file **"aspnet-mssql/app/aspnetapp/Dockerfile-best-practices"** with comments explaining some best practices applied into the Dockerfile

Access the folder and re-create the web-docker image with commands bellow and test the differences:

```
cd aspnet-mssql/app/aspnetapp/
docker build -t web-docker-bestpractices -f Dockerfile-best-practices .
docker run -it web-docker-bestpractices sh
ps aux 
```

Now you can see that the user running the .Net process is **"web-user"** not **"root"**

## Docker Security , scan with Aqua trivy

**Add your user to docker group**

Run the commands bellow to make your user part of the docker group

```
sudo usermod -aG docker $(whoami)
```

**Scan images to find vulnerabilities**

Run the command bellow to pull image **aquasec/trivy** and scan the images **web-docker** or the **web-docker-bestpractices**
```
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker
# OR
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker-bestpractices
```

**Scan images to find vulnerabilities filtering level of vulnerability**

Run the command bellow to scan the images **web-docker** or the **web-docker-bestpractices** and filtering only HIGH and CRITICAL issues.

```
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker | grep -E 'HIGH|CRITICAL'
# OR
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker-bestpractices | grep -E 'HIGH|CRITICAL'
```

**Scan images to find vulnerabilities with reports in HTML format**

**On Linux**
```
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/tmp/.cache/ aquasec/trivy image --format template --template "@contrib/html.tpl" -o /tmp/.cache/web-docker-report.html web-docker
```

**On Windows**
```
docker run -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/tmp/.cache/ aquasec/trivy image --format template --template "@contrib/html.tpl" -o /tmp/.cache/web-docker-report.html web-docker
```

**Build vulnerable image to compare**

```
docker build -t web-docker-vulnerable -f 
Dockerfile-bkp .

docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/tmp/.cache/ aquasec/trivy image --format template --template "@contrib/html.tpl" -o /tmp/.cache/web-docker-vulnerable-report.html web-docker-vulnerable
```

# Fonts

* https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/7.0_release_notes/sect-red_hat_enterprise_linux-7.0_release_notes-linux_containers_with_docker_format-advantages_of_using_docker
* https://docs.aws.amazon.com/whitepapers/latest/docker-on-aws/container-benefits.html
* https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
* https://docs.docker.com/develop/dev-best-practices/
