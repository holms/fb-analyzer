# FB Analyzer

A microservice-based application for analyzing Facebook posts from groups. This project uses a containerized architecture with Python microservices, Redis for queues, and Golang workers for processing tasks.

## Repository Structure

```
fb-analyzer/                       # Main repository with docker-compose and terraform
├── docker-compose.yml             # Orchestrates all services
├── .env                           # Environment variables
├── services/                      # Contains all microservice repos
│   ├── fb-analyzer-api-gateway/   # API Gateway service (Python)
│   ├── fb-analyzer-auth-service/  # Authentication service (Python)
│   ├── fb-analyzer-post-fetcher/  # FB Post fetching service (Python)
│   ├── fb-analyzer-post-analyzer/ # Analysis service (Python)
│   ├── fb-analyzer-notification-service/ # Notification service (Python)
│   ├── fb-analyzer-data-processor/ # Data processing workers (Golang)
│   └── fb-analyzer-frontend/      # React.js frontend with Material UI
├── terraform/                     # Terraform code for infrastructure and GitHub repos
└── infrastructure/                # Infrastructure configurations
    ├── redis/                     # Redis configuration
    ├── mysql/                     # MySQL configuration
    └── nginx/                     # Nginx configuration for routing
```

## Technology Stack

- **Backend Microservices**: Python with FastAPI
- **Message Queue**: Redis for task distribution
- **Workers**: Golang for efficient parallel processing
- **Database**: MySQL for relational data
- **Container Orchestration**: Docker Compose
- **Frontend**: React.js with Material UI
- **Infrastructure as Code**: Terraform

## Getting Started

1. Clone this repository
2. Update the `.env` file with your configuration
3. Run `docker-compose up -d` to start all services

## Microservices

### API Gateway
Entry point for all client requests, handles routing and basic request validation.

### Auth Service
Manages user authentication and authorization.

### Post Fetcher
Connects to Facebook's API to fetch posts from groups.

### Post Analyzer
Analyzes post content, sentiment, engagement metrics.

### Notification Service
Sends notifications to users.

### Data Processor
Golang workers that process tasks from Redis queues.

### Frontend
React.js with Material UI for the user interface.

## Development

Each microservice is contained in its own repository with the prefix `fb-analyzer-` and is included in this main repository.

## Infrastructure

Terraform is used to provision and manage infrastructure resources, including GitHub repositories.
