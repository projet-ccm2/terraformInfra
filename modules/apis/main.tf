variable "project_id" { type = string }

locals {
  services = [
    "run.googleapis.com",
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com",
    "iam.googleapis.com",
    "vpcaccess.googleapis.com",
    "compute.googleapis.com",
    "storage.googleapis.com"
  ]
}

resource "google_project_service" "this" {
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}
