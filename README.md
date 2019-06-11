## Python Web Application

### Section 1

#### 1.1 Objective
Dockerize a simple Python Flask application. And push the created Docker image to Docker Hub Repository.

#### 1.2 Deployment
- Prerequisite for deployment
    - Docker Engine
    - Git
    - cURL or any REST Client like Postman (Optional)

- Instructions
    - `git clone <PROJECT_REPOSITORY_URL> .`
    - `cd deloitte-platform-eng`
    -  `docker build -t python-web-app .`
    -  `docker run -it -d --name python-web-app-cont -p 5000:5000 python-web-app:latest` 

    - Now the container can be accessed on `127.0.0.1:5000`
        - Performing `curl http://127.0.0.1:5000` will return "Hello World"

- Deliverables
  - Dockerfile: Please find it in the root of the project directory.
  - Docker Hub image link: https://hub.docker.com/r/iamvvino/python-web-app
  

#### 1.3 Design Decisions
- The source code was added into the 'image' as part of the build step using the `COPY` instruction in the `Dockerfile`. **Alertanatively, the source could have been mounted to the container using Docker volumes. The disadvantage in adding source code as part of the build step is that everytime the source code changes the image must be rebuilt. But adding all the dependencies as part of the image makes the deployment easier since the container can be just run without need for mouting volumes. On the other hand, using volumes to mount host directory will spare us from rebuilding the Docker image everytime the source code changes. This is because volumes are updated at runtime unlike Dockerfile build steps. When using volumes the container can be jsut stopped and restarted in order to deploy the latest code changes**. 
- In this exercise, I chose to add the source code as part of build step (Dockerfile) because I am pushing the docker image to Docker Hub. Anyone resuing the image can simply run the container since all the dependencies are packaged part of the image (ease of deployment).
- As a note on security. The only port open in the task definition is 5000 (as required by the application). Currenly the application does not support HTTPS since security certificates are not setup on the server. But in a production environment, allowing only HTTPS connections is paramount. 


### Section 2

#### 2.1 Objective
Deploy the Docker image built in section 1 to a container platform.

The chosen container platform is AWS Fargate. The reason being, Fargate is a serverless container ochestration platform which abstracts away the overhead of managing nodes of the cluster as opposed to platforms like Kubernetes or AWS Elastic Container Serivice. 

#### 2.2 Design
The following image illustrates the design of the hosted container in AWS Fargate with TCP traffic flowing via public IP 13.239.23.67 on exposed port 5000. Currently the `service` runs 2 task instances behind an application load balancer.

![Design](https://github.com/vinokanth92/deloitte-platform-eng/blob/master/diagram.jpg)

### Section 3

#### 3.1 Objective
Create a K8 deployment file for this application.

### Design Decisions:
- In order to keep the deployment simple the image pushed to the Docker Hub is used as part of the deployment. Since source code for the application is already part of the Docker image, the deployment file just uses the this image to build containers. In production environment, depending on the complexity and desired downtime of the application, docker volumes may be a better design. 

Deliverables:
- The K8 deployement file called the `app-k8.yaml` can be found in the root of the project directory.






