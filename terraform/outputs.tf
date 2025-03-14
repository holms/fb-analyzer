output "repository_urls" {
  description = "URLs of the created repositories"
  value       = module.github_repositories.repository_urls
}

output "repository_ssh_clone_urls" {
  description = "SSH clone URLs of the created repositories"
  value       = module.github_repositories.repository_ssh_clone_urls
}

output "repository_http_clone_urls" {
  description = "HTTP clone URLs of the created repositories"
  value       = module.github_repositories.repository_http_clone_urls
}
