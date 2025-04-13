# Flask API Deployment on AWS using ECS

This project demonstrates how to:
- Containerize a Flask API using Docker
- Deploy the containerized app on AWS using ECS
- Automate the infrastructure provisioning using **Terraform** (or optionally CloudFormation)
- Automate Docker build and ECR push via a **Bash deployment script**
- Force ECS service to redeploy the new container

---

## 🏗️ Architecture Overview

![Architecture Diagram](images/credera.svg)

**Components:**
- **Flask API**: A simple Python-based web API.
- **Docker**: Used to containerize the Flask application.
- **Amazon ECR**: Docker image registry where the app image is pushed.
- **Amazon ECS (Fargate)**: Used to run the containerized application serverlessly.
- **Terraform / CloudFormation**: Infrastructure as Code tools to provision AWS resources such as:
  - VPC
  - Subnets
  - Security Groups
  - ECS Cluster & Service
  - IAM roles
  - ECR Repository

---

## 🚀 Steps & Structure

### 1. Containerize the Flask API
- Dockerfile created to package the Flask app with dependencies.

### 2. Infrastructure as Code
You can choose either:
- **Terraform** (preferred for cloud-agnostic flexibility) - Used for this Project
- **CloudFormation** (native to AWS)

Both approaches provision:
- ECS Cluster
- Fargate Task Definition
- Service with Load Balancer (optional)
- IAM roles & policies
- ECR Repository

### 3. Deployment Bash Script
A deployment script automates:
- Building the Docker image
- Logging into ECR
- Tagging and pushing the image
- Forcing ECS service to redeploy

## 🏗️ Application Output
![Application Output](images/app.png)