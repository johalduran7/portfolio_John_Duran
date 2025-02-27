# Infrastructure and Deployment Automation

## Overview
This repository automates the provisioning and deployment of a Node.js application on AWS using Terraform, GitHub Actions, Jenkins, and GitLab.

### Repository Structure
- **Infrastructure Pipeline**
  - <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/github.png" width="18"> [`.github/workflows/terraform.yml`](.github/workflows/terraform.yml)
  - <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/jenkins.png" width="18"> [`jenkins/infrastructure/Jenkinsfile`](jenkins/infrastructure/Jenkinsfile)
  - <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/gitlab.png" width="18"> [`GitLab->infra-ci.yml`](https://gitlab.com/johalduran/portfolio_John_Duran/-/blob/dev/ci_gitlab/infra-ci.yml?ref_type=heads)
- **Deployer Pipeline**
  - <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/github.png" width="18"> [`.github/workflows/deployer.yml`](.github/workflows/deployer.yml)
  - <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/jenkins.png" width="18"> [`jenkins/deployer/Jenkinsfile`](jenkins/deployer/Jenkinsfile)
  - <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/gitlab.png" width="18"> [`GitLab->deployer-ci.yml`](https://gitlab.com/johalduran/portfolio_John_Duran/-/blob/dev/ci_gitlab/deployer-ci.yml?ref_type=heads)
- **Infrastructure Code** <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/terraform.png" width="18"> [`./app/terraform/`](./app/terraform/)
- **Application Code** <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/nodejs.png" width="18"> [`./app/src/`](./app/src/)

---
## Terraform Pipeline (Infrastructure Provisioning)
**Triggers:**
- Runs whenever the infrastructure version file [`./app/infra_version.txt`](./app/infra_version.txt) is updated.

**Provisions the following AWS resources:**
- **Networking:** VPC, Subnets, Route Tables, Internet Gateway
- **Compute & Scaling:**
  - Application Load Balancer (ALB), Target Groups, Listeners
  - Auto Scaling Group (ASG) with:
    - Launch Template
    - User Data to:
      - Install Docker and Apache
      - Pull and run the application image from ECR
      - Set up CloudWatch Unified Agent
- **Security:** Security Groups, IAM roles
- **Storage & Configuration:** ECR repository, CloudWatch, Parameter Store keys
- **Backend stored on:** Terraform Cloud

**Additional Features:**
- **ASG Scaling Control:**
  - Desired, min, and max instance values are stored in AWS Systems Manager Parameter Store.
  - Terraform ignores changes to these values to prevent unintended modifications.
  - Only resets on full infrastructure destruction and re-creation.
- **Lifecycle Hook:**
  - Ensures ASG does not add new instances to the ALB until they are fully initialized.
  - Keeps instances in a pending state while setup completes.

**Trigger:** Calls the Deployer Pipeline upon successful provisioning.

---
## Deployer Pipeline (Application Deployment)
**Triggers:**
- Runs when:
  - The application version file [`./app/app_version.txt`](./app/app_version.txt) is updated with a new release tag.
  - Called by the Terraform pipeline after provisioning.

**Deployment Process:**
1. Validates if the specified tag exists in the repository.
2. Checks if the corresponding Docker image already exists in ECR:
   - If **exists**, updates Parameter Store value so the Launch Template User Data pulls the new version.
   - If **does not exist**, builds and pushes the image to ECR.
3. Builds a Docker image from `src/` using a pre-defined [`Dockerfile`](./app/src/Dockerfile) containing all necessary dependencies for the Node.js application.

---
## Demo

### Creating branch, configuring .env, and triggering the pipelines
![Setup](./resources/first_part_gif_portfolio.gif)

### Running Infrastructure and Application pipelines on GitHub Actions. <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/github.png" width="30">
![Setup](./resources/second_part_gif_portfolio.gif)

### Checking deployment on AWS. <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/aws.png" width="30">
![Setup](./resources/third_part_gif_portfolio.gif)

### Jenkins Deployer and Infrastructure pipelines. <img src="https://github.com/johalduran7/portfolio_John_Duran/blob/master/resources/jenkins.png" width="30">
![Setup](./resources/jenkins_gif_portfolio.gif)

---
## Future Improvements
- Enhance lifecycle management for better deployment flexibility.
- Improve monitoring and alerting within CloudWatch.
- Implement blue-green or rolling deployments for zero-downtime updates.

---
## How to Contribute
1. Fork the repository.
2. Create a new branch for your changes.
3. Submit a pull request with a clear description of improvements.

