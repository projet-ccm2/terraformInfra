resource "google_artifact_registry_repository" "repo" {
  project       = var.project_id
  location      = var.region
  repository_id = var.repo_id
  description   = "Docker images for ${var.repo_id}"
  format        = "DOCKER"
}

output "repo_url" {
  value = "${var.region}-docker.pkg.${var.env}/${var.project_id}/${var.repo_id}"
}
