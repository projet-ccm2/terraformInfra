variable "project_id" { type = string }

locals {
  # Cloud Resource Manager API must be enabled first (required for other APIs)
  required_services = [
    "cloudresourcemanager.googleapis.com"
  ]
  
  # Other services that depend on Cloud Resource Manager
  services = [
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com",
    "iam.googleapis.com",
    "compute.googleapis.com",
    "storage.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}

# Enable Cloud Resource Manager API first (required for other APIs)
resource "google_project_service" "required" {
  for_each           = toset(local.required_services)
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

# Enable other services (they depend on Cloud Resource Manager)
resource "google_project_service" "this" {
  for_each           = toset(local.services)
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false

  depends_on = [google_project_service.required]
}
