#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

# Define variables
AWS_REGION="us-east-1"  
ECR_REPO="python-api"   
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)  
CLUSTER_NAME="python-api-cluster"   
SERVICE_NAME="python-api-service"  

echo "Building Docker image..."
# Build Docker image using local Dockerfile
docker build -t $ECR_REPO .

echo "Logging into AWS ECR..."
# Authenticate Docker to ECR Registry
aws ecr get-login-password --region $AWS_REGION | \
docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

echo "Tagging Docker image for ECR..."
# Tag the built image for pushing to ECR
docker tag $ECR_REPO:latest ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/$ECR_REPO:latest

echo "Pushing Docker image to AWS ECR..."
# Push the Docker image to AWS ECR
docker push ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/$ECR_REPO:latest


# Force ECS service to pick up the new image
echo "Forcing ECS service to redeploy with the new image..."

aws ecs update-service \
  --cluster $CLUSTER_NAME \
  --service $SERVICE_NAME \
  --force-new-deployment \
  --region $AWS_REGION