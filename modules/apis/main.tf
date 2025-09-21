variable "project_id" { type = string }

locals {
  services = [
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com",
    "iam.googleapis.com",
    "compute.googleapis.com",
    "storage.googleapis.com",
    // Required for Private Service Connect / VPC peering for Cloud SQL Private IP
    "servicenetworking.googleapis.com",
    // Optional but recommended for Serverless VPC Access Connector
    "vpcaccess.googleapis.com"
  ]
}

resource "google_project_service" "this" {
  for_each           = toset(local.services)
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}
