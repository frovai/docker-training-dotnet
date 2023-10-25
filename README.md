# Docker hands-on with .Net Application
This reposiroty was created to train people running Docker containers for .Net application , helping understand the using of Dockerfile, docker-compose and to teach some best practices for creating a Docker container and applying Security on your Docker containers

## **Prerequisites**

### **Install Docker on Windows or Linux**

Follow the steps inside official Docker documentation:

[Install Docker Windows](https://docs.docker.com/desktop/install/windows-install/)

[Install Docker Linux](https://docs.docker.com/desktop/install/linux-install/)

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

## **Docker commands**

### **Containers:**

* **create** — Creates a container from an image.
```
docker create [imageid]
```
* **start** — Starts a container that already exists.
```
docker start [containerid]
```
* **restart** — Restarts an existing container.
```
docker restart [containerid]
```
* **run** , **run -di** — Creates a new container and starts it like daemon process.
-d = Run the container in the background
-i = Interactive mode. Keeps STDIN open even without console attached
```
docker run -di [imageid]
```
* **ps** — Lists the containers that are running.
```
docker ps # (containers up)
docker ps -a # (all containers on the machine)
```
* **inspect** — Inspects container configurations.
```
docker inspect [containerid]
```
* **logs** — Shows the container logs.
```
docker logs [containerid]
```
* **stop** — Stops the container safely.
```
docker stop [containerid]
```
* **kill** — Forces the container's main process to stop.
```
docker kill [containerid]
```
* **rm** , **rm $(docker ps -aq)** — Deletes a container, only works when it is stopped. Delete all containers
```
docker rm [containerid]
docker rm $(docker ps -aq) ## Example command to delete all containers listed on the filter
```
* **exec** , **exec -it** — Executes a command in the container.
```
docker exec -ti [containerid] [command]
```
* **stats** — Shows the container's consumption/statistics.
```
docker stats [containerid]
```
* **top** — Shows running processes.
```
docker top [containerid]
```
* **port** – Shows the exposed and open ports of the container.
```
docker port [containerid]
```
* **rename** — Renames a container.
```
docker rename [containerid] [newname]
```
* **export** — Exports the container's Filesystem to a tar.
```
docker export [containerid] > file_name.tar
```
### **Images:**

* **search** — Displays existing images on Docker Hub.
```
docker search [image name you want]
docker search ubuntu ## Example
```
* **build** — Builds an image from a Dockerfile.
```
docker build -t firstimage [Dockerfile path]
docker built -t MyImageName . ## Example
```
* **image** - List local images
```
docker images
```
* **commit** — Creates a new image after changing the container
```
docker commit [container_id] NewImageName:tag
docker commit b612618ee603 web-docker-image:1.0  ## Example
```
* **tag** - Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
```
docker tag [image_id] NewImageName:tag
docker tag 3c17532d9acc myfirstimage ## Example with default latest tag
docker tag 3c17532d9acc myfirstimage:1.0 ## Example with tag associated
```
* **push** — Pushes an image from the Docker Registry.
```
docker push registry-repository-address
docker push localhost:5000/myfirstimage ## Example local registry
docker push 2427556123456.dkr.ecr.us-east-1.amazonaws.com/myfirstimage ## Example remote Registry AWS ECR
```
* **pull** — Pulls an image from the Registry.
```
docker pull localhost:5000/myfirstimage ## Example local registry
docker pull ubuntu:22.04 ## Example default Docker Hub Registry
```
* **load** - Load an image from a tar archive or STDIN
```
docker load < [path/to/image_file.tar]
docker load -i [path/to/image_file.tar]
docker load -i /home/ubuntu/MyExportedImage.tar ## Example
```
* **history** — Displays the evolution/history of the image since it was created, show its layers.
```
docker history [imageid]
```
* **inspect** — Inspects the container's configurations, as well as its layers.
```
docker inspect [imageid]
```
* **rmi** , **rmi $(docker images -aq)**— Delete an image or delete all images
```
docker rmi [imageid]
docker rmi $(docker images -aq) ## Example command to delete all images filtered
```
* **save** — Saves one or more images to a tar.
```
docker save [imageId or imageName] > ExportedMyLocalImageName.tar
docker save -o ExportedMyLocalImageName.tar [imageId or imageName]
docker save ubuntu:22.04 > Ubuntu22-04.tar ## Example 1 exporting .tar file on the folder executed the command from Image Name.
docker save -o MinhaImagemExportada.tar 185661fea235 ## Example 2 exporting .tar file on the folder executed the command from Image ID.
```

**Other important ones:**

* **docker version** — Lists information about the docker client and docker server.
* **docker login** — Login into some Docker Registry service, like Docker Hub, AWS ECR, etc.
* **docker system prune** — Deletes disused containers, disused network bridges , build cache and old unused images **(be very careful with this command)**

## **Dockerfile**

Dockerfile is a file that you need to create, to design your docker image. 

Dockerfile is structured in Layers, so each line on your Dockerfile file is a different layer. All the layers are refered to Image and are Read-Only excepted the last one that refers to the Container and it's Read-Write.

![DockerFile Structure](.images/Dockerfile-Structure.webp)

## **Docker-compose**

Docker-compose is another feature of Docker to simply document and create your Docker environment without having to decorate docker commands, you create your docker environments in a more performatic way as well.

## **Hands-on**

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
**[http://localhost:8080](http://localhost:8080)**

![Web-docker Page](.images/output.jpg)

**Create a container db-docker**

The commands bellow creates/runs a container from the image **"mcr.microsoft.com/mssql/server"**, named your container as **"db-docker"** , the **"-e"** exposes environments **'ACCEPT_EULA'** and **'SA_PASSWORD'** with your respective values, the **"-p"** exposes the port **"1433"** on your host and the **"1433"** inside your container the **"-di"** is a flag to make the container runs as a daemon process an make it interactable.
```
docker run --name db-docker -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=example_123' -p 1433:1433 -di mcr.microsoft.com/mssql/server
```

**Create Docker Network docker-network**

The command bellow create a docker network called **"docker-network"**

```
docker network create docker-network
```

**Create a container web-docker using docker-network**

The **"--network docker-network"** attaches the container **"web-docker"** to docker network **"docker-network"**.

```
docker run --name web-docker -p 8080:80 --network docker-network -di web-docker 
```

**Create a container db-docker using docker-network**

The **"--network docker-network"** attaches the container **"db-docker"** to docker network **"docker-network"**.

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

Create your file called **"docker-compose.yml"** and run the all the commands bellow inside the folder where is the file

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
docker exec -it web-docker sh
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
docker exec -it web-docker sh
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

## Best practices Docker and Docker-compose

[Docker best practices](https://docs.docker.com/develop/develop-images/instructions/)

It was created the file **"aspnet-mssql/app/aspnetapp/Dockerfile-best-practices"** with comments explaining some best practices applied into the Dockerfile

Access the folder and re-create the web-docker image with commands bellow and test the differences:

```
cd aspnet-mssql/app/aspnetapp/
docker build -t web-docker-best -f Dockerfile-best-practices .
docker exec -it web-docker-best sh
ps aux
## OR
cd aspnet-mssql
docker-compose -f docker-compose-best.yml build
docker-compose -f docker-compose-best.yml up -d
docker exec -it web-docker-best sh
ps aux 
```
Now you can see that the user running the .Net process is **"web-user"** not **"root"**

**Specify different docker-compose file, Using Global and default envs**

Now, uncomment the lines bellow, inside the file **"docker-compose-best.yml"** and re-run the command to create the stack.
```
      #APPLICATION_NAME: ${APPLICATION_NAME}
      #LANGUAGE: ${LANGUAGE}
      #OS_SYSYEM: ${OS_SYSTEM}
    #env_file:
    #  - .env.Global   
```
This lines will create the stack calling the env file **".env.Global"** and mapping the 3 variables according to the **".env.Global"** file.
```
cd aspnet-mssql
docker-compose -f docker-compose-best.yml up -d
```

**Specify different docker-compose file, Using Global env and Specifying env**

```
cd aspnet-mssql
docker-compose --env-file .env.stg -f .\docker-compose-best.yml up -d
```

## **Docker Security , scan with Aqua trivy**

**Add your user to docker group**

Run the commands bellow to make your user part of the docker group

```
sudo usermod -aG docker $(whoami)
```

**Scan images to find vulnerabilities**

Run the command bellow to pull image **aquasec/trivy** and scan the images **web-docker** or the **web-docker-best**
```
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker
# OR
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker-best
```

**On LINUX , Scan images to find vulnerabilities filtering level of vulnerability**

Run the command bellow to scan the images **web-docker** and **web-docker-best** , the scan will filter only HIGH and CRITICAL issues.

```
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker | grep -E 'HIGH|CRITICAL'
# AND
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker-best | grep -E 'HIGH|CRITICAL'
```

**On WINDOWS , Scan images to find vulnerabilities filtering level of vulnerability**

Run the command bellow to scan the images **web-docker** and **web-docker-best** , the scan will filter only HIGH and CRITICAL issues.

```
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker | findstr /R /C:"HIGH" /C:"CRITICAL"
# AND
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker-best | findstr /R /C:"HIGH" /C:"CRITICAL"
```

**On LINUX, Scan images to find vulnerabilities with reports in HTML format**

Run the command bellow to scan the images **web-docker** and **web-docker-best** , the scan will generate a HTML Report listing all the vulnerabilities, LOW, MEDIUM, HIGH and CRITICAL:

```
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/tmp/.cache/ aquasec/trivy image --format template --template "@contrib/html.tpl" -o /tmp/.cache/web-docker-report.html web-docker
## AND
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:/tmp/.cache/ aquasec/trivy image --format template --template "@contrib/html.tpl" -o /tmp/.cache/web-docker-best-report.html web-docker-best
```

**On WINDOWS, Scan images to find vulnerabilities with reports in HTML format**

Run the command bellow to scan the images **web-docker** and **web-docker-best** , the scan will generate a HTML Report listing all the vulnerabilities, LOW, MEDIUM, HIGH and CRITICAL:

```
docker run -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/tmp/.cache/ aquasec/trivy image --format template --template "@contrib/html.tpl" -o /tmp/.cache/web-docker-report.html web-docker
## AND
docker run -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/tmp/.cache/ aquasec/trivy image --format template --template "@contrib/html.tpl" -o /tmp/.cache/web-docker-best-report.html web-docker-best
```

**COMPARE IMAGE VULNERABILITIES**

**Command on LINUX , web-docker image Total vulnerabilities** 
```
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker | grep Total
```
**Command on WINDOWS , web-docker image Total vulnerabilities** 
```
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker | findstr /R /C:"Total"
```
![Web-docker Vulnerabilities](.images/Total-vulnerabilities-web-docker.png)

**Command on LINUX , web-docker-best image Total vulnerabilities** 
```
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker-best | grep Total
```
**Command on WINDOWS , web-docker-best image Total vulnerabilities** 
```
docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image web-docker-best | findstr /R /C:"Total"
```
![Web-docker-best Vulnerabilities](.images/Total-vulnerabilities-web-docker-best.png)

## **Fonts**

* https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/7.0_release_notes/sect-red_hat_enterprise_linux-7.0_release_notes-linux_containers_with_docker_format-advantages_of_using_docker
* https://docs.aws.amazon.com/whitepapers/latest/docker-on-aws/container-benefits.html
* https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
* https://docs.docker.com/develop/dev-best-practices/
* https://www.youtube.com/watch?v=sK5i-N34im8
* https://docs.docker.com/compose/environment-variables/env-file/
* https://12factor.net/pt_br/
* https://stackoverflow.com/questions/54988792/docker-compose-healthcheck-use-environment-variables

