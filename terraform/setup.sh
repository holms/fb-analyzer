#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}FB Analyzer - Terraform Setup Script${NC}"
echo "This script will help you set up the Terraform configuration for FB Analyzer."

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo -e "${RED}Error: Terraform is not installed.${NC}"
    echo "Please install Terraform first: https://www.terraform.io/downloads.html"
    exit 1
fi

# Check if .env exists, if not create it
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}Creating .env file for environment variables...${NC}"
    
    # Prompt for GitHub token
    echo -n "Enter your GitHub personal access token: "
    read -s github_token
    echo ""
    
    # Prompt for GitHub owner
    echo -n "Enter your GitHub username or organization name: "
    read github_owner
    
    # Prompt for shell type
    echo -e "${YELLOW}Which shell are you using?${NC}"
    echo "1) bash/zsh"
    echo "2) fish"
    echo -n "Enter your choice (1-2): "
    read shell_choice
    
    # Create .env file with restricted permissions
    umask 077  # Set file permissions to be restricted to owner only
    
    if [ "$shell_choice" = "2" ]; then
        # Fish shell format
        cat > .env << EOF
# GitHub credentials for fish shell
# Use: source .env
set -x TF_VAR_github_token ${github_token}
set -x TF_VAR_github_owner ${github_owner}
EOF
        echo -e "${GREEN}.env file created for fish shell.${NC}"
        echo -e "${YELLOW}To use: source .env${NC}"
    else
        # Bash/zsh format
        cat > .env << EOF
# GitHub credentials for bash/zsh
# Use: source .env
export TF_VAR_github_token=${github_token}
export TF_VAR_github_owner=${github_owner}
EOF
        echo -e "${GREEN}.env file created for bash/zsh shell.${NC}"
        echo -e "${YELLOW}To use: source .env${NC}"
    fi
    
    echo -e "${YELLOW}Warning: This file contains sensitive information and should not be committed to version control.${NC}"
else
    echo -e "${YELLOW}.env file already exists.${NC}"
fi

# Reminder to source the .env file
echo -e "${YELLOW}Remember to source your .env file before running Terraform commands:${NC}"
echo -e "${GREEN}source .env${NC}"

# Initialize Terraform
echo -e "${YELLOW}Initializing Terraform...${NC}"
terraform init

# Plan Terraform changes
echo -e "${YELLOW}Planning Terraform changes...${NC}"
terraform plan -out=tfplan

# Ask for confirmation before applying
echo -e "${YELLOW}Do you want to apply these changes? (y/n)${NC}"
read -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Apply Terraform changes
    echo -e "${YELLOW}Applying Terraform changes...${NC}"
    terraform apply tfplan
    
    # Output repository URLs
    echo -e "${GREEN}GitHub repositories created successfully!${NC}"
    echo -e "${YELLOW}Repository URLs:${NC}"
    terraform output repository_urls
    
    echo -e "${YELLOW}SSH Clone URLs:${NC}"
    terraform output repository_ssh_clone_urls
else
    echo -e "${YELLOW}Terraform apply cancelled.${NC}"
fi

echo -e "${GREEN}Setup complete!${NC}"
