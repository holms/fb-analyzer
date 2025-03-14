output "repository_urls" {
  description = "URLs of the created repositories"
  value = {
    for name, repo in github_repository.repo : name => repo.html_url
  }
}

output "repository_ssh_clone_urls" {
  description = "SSH clone URLs of the created repositories"
  value = {
    for name, repo in github_repository.repo : name => repo.ssh_clone_url
  }
}

output "repository_http_clone_urls" {
  description = "HTTP clone URLs of the created repositories"
  value = {
    for name, repo in github_repository.repo : name => repo.http_clone_url
  }
}
