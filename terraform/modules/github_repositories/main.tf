resource "github_repository" "repo" {
  for_each = { for repo in var.repositories : repo.name => repo }

  name        = each.value.name
  description = each.value.description
  visibility  = "public"  # Making repositories public instead of private
  auto_init   = each.value.auto_init

  # Repository features
  has_issues        = true
  has_projects      = true
  has_wiki          = true
  has_downloads     = true

  # Merge strategies - only allow rebase merges as per requirements
  allow_merge_commit = false
  allow_squash_merge = false
  allow_rebase_merge = true
  allow_auto_merge   = true
  delete_branch_on_merge = true

  # Add gitignore templates for different repository types
  gitignore_template = each.value.name == "fb-analyzer-data-processor" ? "Go" : (
    contains(["fb-analyzer-frontend"], each.value.name) ? "Node" : "Python"
  )

  # Add license template
  license_template = "mit"

  # Add topics based on repository type
  topics = concat(
    ["fb-analyzer", "microservices", "docker"],
    each.value.name == "fb-analyzer-data-processor" ? ["golang", "workers"] : [],
    each.value.name == "fb-analyzer-frontend" ? ["react", "material-ui"] : [],
    contains(["fb-analyzer-api-gateway", "fb-analyzer-auth-service", "fb-analyzer-post-fetcher", "fb-analyzer-post-analyzer", "fb-analyzer-notification-service"], each.value.name) ? ["python", "fastapi"] : []
  )
}

# Use simpler branch protection for personal accounts
resource "github_branch_protection" "main" {
  for_each = { for repo in var.repositories : repo.name => repo if repo.auto_init }

  repository_id  = github_repository.repo[each.key].node_id
  pattern        = "main"
  enforce_admins = false

  # Require pull request reviews before merging
  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = false
  }

  # Require status checks to pass before merging
  required_status_checks {
    strict = true
    # Using contexts for compatibility
    contexts = ["ci/github-actions"]
  }
}
