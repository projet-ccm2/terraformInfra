resource "google_artifact_registry_repository" "docker_repo" {
  provider = google
  location     = "europe-west1"
  repository_id = var.repository_id
  description  = "Repo Docker pour les microservices"
  format       = "DOCKER"
}
