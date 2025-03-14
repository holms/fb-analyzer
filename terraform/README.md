# FB Analyzer - Terraform Configuration

This directory contains Terraform configurations to manage the infrastructure for the FB Analyzer project, including GitHub repositories.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0 or later)
- GitHub account with a Personal Access Token (PAT) with appropriate permissions:
  - `repo` - Full control of private repositories
  - `admin:org` - Full control of orgs and teams (if using an organization)

## Setup

1. Create a `terraform.tfvars` file based on the provided example:

```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Edit the `terraform.tfvars` file and add your GitHub token and owner information:

```hcl
github_token = "your_github_personal_access_token"
github_owner = "your_github_username_or_organization"
```

## Usage

Initialize Terraform:

```bash
terraform init
```

Plan the changes:

```bash
terraform plan
```

Apply the changes:

```bash
terraform apply
```

Destroy the infrastructure when no longer needed:

```bash
terraform destroy
```

## Modules

- `github_repositories`: Creates and manages GitHub repositories for the FB Analyzer project

## Repository Structure

The Terraform configuration will create the following repositories:

- `fb-analyzer`: Main repository with docker-compose and terraform
- `fb-analyzer-api-gateway`: API Gateway service
- `fb-analyzer-auth-service`: Authentication service
- `fb-analyzer-post-fetcher`: Facebook post fetching service
- `fb-analyzer-post-analyzer`: Post analysis service
- `fb-analyzer-notification-service`: Notification service
- `fb-analyzer-data-processor`: Golang data processing workers
- `fb-analyzer-frontend`: React.js frontend with Material UI

## State Management

By default, the Terraform state is stored locally. For production environments, it's recommended to use a remote backend like Terraform Cloud, AWS S3, or similar. Uncomment and configure the `backend` block in `providers.tf` to use a remote backend.
