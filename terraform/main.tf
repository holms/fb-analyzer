# Provider configuration moved to providers.tf

# Create GitHub repositories for each microservice
module "github_repositories" {
  source = "./modules/github_repositories"
  
  github_owner = var.github_owner
  repositories = [
    {
      name        = "fb-analyzer"
      description = "Main repository for FB Analyzer project with docker-compose and terraform"
      visibility  = "private"
      auto_init   = true
    },
    {
      name        = "fb-analyzer-api-gateway"
      description = "API Gateway service for FB Analyzer"
      visibility  = "private"
      auto_init   = true
    },
    {
      name        = "fb-analyzer-auth-service"
      description = "Authentication service for FB Analyzer"
      visibility  = "private"
      auto_init   = true
    },
    {
      name        = "fb-analyzer-post-fetcher"
      description = "Facebook post fetching service for FB Analyzer"
      visibility  = "private"
      auto_init   = true
    },
    {
      name        = "fb-analyzer-post-analyzer"
      description = "Post analysis service for FB Analyzer"
      visibility  = "private"
      auto_init   = true
    },
    {
      name        = "fb-analyzer-notification-service"
      description = "Notification service for FB Analyzer"
      visibility  = "private"
      auto_init   = true
    },
    {
      name        = "fb-analyzer-data-processor"
      description = "Golang data processing workers for FB Analyzer"
      visibility  = "private"
      auto_init   = true
    },
    {
      name        = "fb-analyzer-frontend"
      description = "React.js frontend with Material UI for FB Analyzer"
      visibility  = "private"
      auto_init   = true
    }
  ]
}
