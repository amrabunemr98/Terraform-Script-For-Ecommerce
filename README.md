# eCommerce Application Deployment

This repository contains the necessary scripts and configurations to deploy an eCommerce application architecture using Terraform and GitHub Actions. The architecture includes a Node.js frontend, a Laravel PHP backend, and a MySQL database hosted on AWS.

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Task Group A: Terraform Scripts](#task-group-a-terraform-scripts)
   - [Requirements](#requirements)
   - [Resources Created](#resources-created)
   - [Usage](#usage)
3. [Task Group B: GitHub Actions CI/CD](#task-group-b-github-actions-cicd)
   - [Overview](#overview)
   - [Frontend Deployment](#frontend-deployment)
   - [Backend Deployment](#backend-deployment)
   - [Monitoring and Alerts](#monitoring-and-alerts)

## Architecture Overview

The application architecture consists of the following components:

- **Frontend**: Node.js application running on Ubuntu 22.04.
- **Backend**: Laravel PHP application running on Ubuntu 22.04.
- **Database**: MySQL Community version 8 hosted on RDS (with no internet exposure).

## Task Group A: Terraform Scripts

### Requirements

- Terraform installed on your machine.
- AWS account with proper IAM permissions.

### Resources Created

The following resources are created using the Terraform script:

1. **Backend Machine**: 
   - Type: Ubuntu 22.04
   - vCPU: 1
   - RAM: 1 GB
   - Disk: 8 GB
   - Public IP: Yes

2. **Frontend Machine**: 
   - Type: Ubuntu 22.04
   - vCPU: 1
   - RAM: 1 GB
   - Disk: 8 GB
   - Public IP: Yes

3. **MySQL RDS Instance**: 
   - Version: MySQL 8 Community
   - Type: Lowest plan
   - Internet Exposure: No

### Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/amrabunemr98/Terraform-Script-For-Ecommerce.git
   cd Terraform-Script-For-Ecommerce
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Plan the deployment:
   ```bash
   terraform plan
   ```

4. Apply the changes:
   ```bash
   terraform apply
   ```

## Task Group B: GitHub Actions CI/CD

### Overview

This section automates the deployment of the Node.js frontend and Laravel PHP backend applications using GitHub Actions.

### Frontend Deployment

Any update on the main branch of the frontend repository will trigger the following steps:

1. **Build Step**:
   - Command: `echo building.....`

2. **Deployment Step**:
   - Deploys the latest build to the Ubuntu 22.04 machine.

#### GitHub Action Configuration
```yaml
name: Laravel CI/CD Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  php-tests:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: 8.0

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1  # Update with your region

      - name: SSH into EC2 and run tests
        run: |
          echo "${{ secrets.EC2_SSH_KEY }}" > key.pem
          chmod 400 key.pem
          ssh -o StrictHostKeyChecking=no -i key.pem ec2-user@${{ secrets.EC2_PUBLIC_IP }} << EOF
            echo "Running tests on EC2..."
            cd /path/to/your/project
            composer install
            php artisan test
          EOF

  deploy:
    runs-on: ubuntu-latest
    needs: php-tests
    steps:
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1  # Update with your region

      - name: SSH into EC2 and deploy
        run: |
          echo "${{ secrets.EC2_SSH_KEY }}" > key.pem
          chmod 400 key.pem
          ssh -o StrictHostKeyChecking=no -i key.pem ec2-user@${{ secrets.EC2_PUBLIC_IP }} << EOF
            echo "Deploying to production..."
            cd /path/to/your/project
            # Add your deployment commands here
            php artisan migrate --force
          EOF
```
[View Frontend CI/CD Workflow](https://github.com/amrabunemr98/NodeJs-app-Frontend/blob/master/.github/workflows/ci-cd.yml)

### Backend Deployment

Any update on the main branch of the Laravel PHP app repository will trigger an automatic deployment that executes a shell script to:

1. Pull the latest changes.
2. Run `php artisan migrate` to apply schema changes automatically.

#### GitHub Action Configuration
```yaml
name: Node.js CI/CD Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1  # Update with your region

      - name: SSH into EC2 and run build commands
        run: |
          echo "${{ secrets.EC2_SSH_KEY }}" > key.pem
          chmod 400 key.pem
          ssh -o StrictHostKeyChecking=no -i key.pem ec2-user@${{ secrets.EC2_PUBLIC_IP }} << EOF
            echo "Running build commands on EC2..."
            cd /path/to/your/project  # Update with the correct path to your project
            npm install  # Install dependencies
            npm test     # Run tests
          EOF

  deploy:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1  # Update with your region

      - name: SSH into EC2 and deploy
        run: |
          echo "${{ secrets.EC2_SSH_KEY }}" > key.pem
          chmod 400 key.pem
          ssh -o StrictHostKeyChecking=no -i key.pem ec2-user@${{ secrets.EC2_PUBLIC_IP }} << EOF
            echo "Deploying to production..."
            cd /path/to/your/project  # Update with the correct path to your project
            npm install --production  # Install production dependencies
            npm run build             # Run build command if applicable
            # Add any other deployment commands here
          EOF
```
[View Backend CI/CD Workflow](https://github.com/amrabunemr98/Laravel-php-app-backend/blob/11.x/.github/workflows/ci-cd.yml)

### Monitoring and Alerts

CPU utilization on the machines is monitored, and alerts will be sent to your email if the CPU utilization exceeds 50%. Ensure that you configure the monitoring service accordingly.
```

You can save this content as `README.md` in your repository. Let me know if you need any more changes or additions!
