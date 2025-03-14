terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
  
  # Uncomment this block to use Terraform Cloud for state management
  # backend "remote" {
  #   organization = "your-organization"
  #   workspaces {
  #     name = "fb-analyzer"
  #   }
  # }
  
  required_version = ">= 1.0.0"
}

provider "github" {
  # Using environment variables for credentials directly
  # This ensures the token is passed correctly to the GitHub API
  token = var.github_token
  owner = var.github_owner
}
