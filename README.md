# Terraform Flask + Express Docker Application on AWS

## 📌 Project Overview
This project demonstrates deploying a **Flask backend** and an **Express frontend** as Docker containers on **AWS ECS (Fargate)** using **Terraform**.  
The application is exposed using an **Application Load Balancer (ALB)** with **path-based routing**.

---

## 🧱 Architecture Overview

- **Frontend (Express + HTML)**
  - Serves a static form UI
  - Runs on port `3000`
  - Deployed as an ECS Fargate service

- **Backend (Flask API)**
  - Handles form submissions
  - Exposes `/api/submit`
  - Runs on port `5000`
  - Deployed as an ECS Fargate service

- **Application Load Balancer**
  - `/` → Express frontend
  - `/api/*` → Flask backend

- **Infrastructure**
  - VPC with public subnets
  - Security Groups
  - ECR repositories
  - ECS Cluster & Services
  - Remote Terraform state (S3 + DynamoDB)

---

## 🧱 Architecture Diagram

yaml
Copy code
            ┌─────────────────────┐
            │       Browser        │
            └──────────┬──────────┘
                       │
                       ▼
            ┌─────────────────────┐
            │ Application Load     │
            │ Balancer (ALB)       │
            └──────────┬──────────┘
               /        │        \
              /         │         \
             ▼          ▼          ▼
    ┌─────────────┐  ┌─────────────┐
    │ Express      │  │ Flask       │
    │ Frontend     │  │ Backend API │
    │ ECS Fargate  │  │ ECS Fargate │
    │ Port 3000    │  │ Port 5000   │
    └─────────────┘  └─────────────┘
yaml
Copy code

---

## 🚀 Deployment Steps

### 1️⃣ Build and Push Docker Images (Mac)

```bash
# Frontend
cd express-frontend
docker build -t express-frontend:vFINAL .
docker tag express-frontend:vFINAL <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/express-frontend:vFINAL
docker push <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/express-frontend:vFINAL
bash
Copy code
# Backend (optional if unchanged)
cd flask-backend
docker build -t flask-backend:latest .
docker tag flask-backend:latest <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/flask-backend:latest
docker push <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/flask-backend:latest
2️⃣ Terraform Deployment (EC2 Runner)
bash
Copy code
cd terraform
terraform init
terraform plan
terraform apply
🌐 Accessing the Application
After deployment, Terraform outputs the ALB DNS:

ini
Copy code
alb_dns_name = flask-express-alb-xxxx.us-east-1.elb.amazonaws.com
