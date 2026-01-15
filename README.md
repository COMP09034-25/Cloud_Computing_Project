# Cloud Native Application Project  
## AWS Container Service Deployment: A Comparative Study of Elastic Beanstalk and Amazon ECS

---

## Project Overview

This repository contains the source code, configuration files, and deployment artefacts for a comparative deployment of a containerised catalog service application using two Amazon Web Services (AWS) container deployment platforms:

- AWS Elastic Beanstalk (Docker platform)
- Amazon Elastic Container Service (ECS) on AWS Fargate

The objective of the project is to evaluate these services based on abstraction level, deployment complexity, operational responsibility, cloud-native features, and developer experience.

A GitOps-based CI/CD pipeline implemented using GitHub Actions is used to automate the build and deployment process.

This repository supports the accompanying academic report titled:

**AWS Container Service Deployment: A Comparative Study of Elastic Beanstalk and Amazon ECS**

---

## Technologies Used

- **Amazon Web Services (AWS)**
  - Elastic Beanstalk
  - Amazon ECS (Fargate)
  - Amazon Elastic Container Registry (ECR)
  - Application Load Balancer (ALB)
  - AWS CloudWatch
- Docker
- GitHub Actions (CI/CD)
- GitOps-based deployment approach

---

## CI/CD Pipeline Overview

This project implements a GitOps-based CI/CD pipeline using **GitHub Actions** to automate the build, containerisation, and deployment of the application to AWS services.

The pipeline ensures consistent and repeatable deployments for both **AWS Elastic Beanstalk** and **Amazon ECS (Fargate)**.

---

## CI/CD Workflow Structure

The CI/CD configuration is defined under:

```text
.github/workflows/
├── ecrimagepush.yml      # Builds the application, creates a Docker image, and pushes it to Amazon ECR
├── deploy-eb.yml         # Deploys the Docker image to AWS Elastic Beanstalk using Dockerrun.aws.json
└── deploy-ecs.yml        # Deploys the Docker image to Amazon ECS (Fargate) using the ECS task definition

```
---

## CI/CD Workflow Descriptions

### ecrimagepush.yml – Docker Image Build and Push

This workflow is responsible for building and publishing the application container image to **Amazon Elastic Container Registry (ECR)**.

The workflow performs the following steps:

- Checks out the source code from the repository
- Builds the Java application using Gradle
- Builds a Docker image using the provided `Dockerfile`
- Authenticates with Amazon ECR
- Pushes the Docker image to the configured ECR repository

This workflow provides the container image required for downstream deployment workflows.

---

### deploy-eb.yml – AWS Elastic Beanstalk Deployment

This workflow handles deployment of the containerised application to **AWS Elastic Beanstalk** using the Docker platform.

The deployment process includes:

- Pulling the latest Docker image from Amazon ECR
- Using the `Dockerrun.aws.json` file to define container configuration
- Deploying the application to an Elastic Beanstalk environment
- Allowing Elastic Beanstalk to manage infrastructure provisioning, scaling, and load balancing

This workflow abstracts most infrastructure management, enabling rapid deployment with minimal operational overhead.

---

### deploy-ecs.yml – Amazon ECS (Fargate) Deployment

This workflow deploys the application to **Amazon ECS using the AWS Fargate launch type**.

Key steps include:

- Registering or updating the ECS task definition defined in `ecs-task-def.json`
- Updating the ECS service to use the latest Docker image
- Running containers on Fargate without managing underlying servers
- Integrating with an Application Load Balancer for external traffic access

This workflow provides fine-grained control over container configuration and networking while maintaining a serverless execution model.

---

## CI/CD Pipeline Execution Flow

The CI/CD pipeline executes in the following order:

1. Code changes are pushed to the `main` branch
2. The `ecrimagepush.yml` workflow builds and pushes the Docker image to ECR
3. On successful image push:
   - The `deploy-eb.yml` workflow deploys the application to AWS Elastic Beanstalk
   - The `deploy-ecs.yml` workflow deploys the application to Amazon ECS (Fargate)
4. The application is updated automatically on both deployment platforms

This pipeline follows GitOps principles, where Git serves as the single source of truth for deployments.

---

## Automated Deployment Trigger

The CI/CD pipeline can be triggered by pushing changes to the repository:

```bash
git commit -am "Trigger CI/CD deployment"
git push origin main
```

This action initiates the complete automated build and deployment process.

---

## Deployed Application Endpoints

**Note:** AWS resources may be stopped after submission to avoid unnecessary costs.

### AWS Elastic Beanstalk Endpoint

http://catalogservice-env-1.eba-r9eekp5p.eu-west-1.elasticbeanstalk.com/

### Amazon ECS (Fargate) Endpoint

https://catalogservice-alb-1494408583.eu-west-1.elb.amazonaws.com/

---

## Academic Context

This CI/CD implementation was completed as part of the **ATU Cloud Native Computing** module.

It demonstrates:

- GitOps-based CI/CD practices  
- Automated Docker image creation and publishing  
- Multi-platform AWS container deployments  
- Practical DevOps workflows aligned with cloud-native principles  

---

## Cost Management

AWS resources were deployed using minimal configurations and monitored throughout testing.

All resources were terminated after validation to avoid unnecessary costs.

---


