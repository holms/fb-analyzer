variable "github_owner" {
  description = "GitHub username or organization name"
  type        = string
}

variable "repositories" {
  description = "List of repositories to create"
  type = list(object({
    name        = string
    description = string
    visibility  = string
    auto_init   = bool
  }))
}
