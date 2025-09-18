# Runtime service account
resource "google_service_account" "run" {
  account_id   = "${var.service_name}-sa"
  display_name = "SA for Cloud Run ${var.service_name}"
}

# Allow the service to connect to Cloud SQL
resource "google_project_iam_member" "sql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.run.email}"
}

resource "google_cloud_run_service" "svc" {
  name     = var.service_name
  location = var.region

  template {
    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = var.instance_connection_name
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector_name
        "run.googleapis.com/vpc-access-egress" = "private-ranges-only"
      }
    }
    spec {
      service_account_name = google_service_account.run.email
      containers {
        image = var.image

        # Typical DB envs; in prod, prefer Secret Manager or IAM DB auth
        env {
          name = "DB_HOST"
          value = "/cloudsql/${var.instance_connection_name}"
        }
        env {
          name = "DB_USER"
          value = var.db_user
        }
        env {
          name = "DB_NAME"
          value = var.db_name
        }
        env {
          name = "DB_PASSWORD"
          value = var.db_password
        }
      }
    }
  }

  traffic {
    percent = 100
    latest_revision = true
  }
}

# Public access (optional)
resource "google_cloud_run_service_iam_member" "unauth" {
  count    = var.allow_unauthenticated ? 1 : 0
  location = var.region
  project  = var.project_id
  service  = google_cloud_run_service.svc.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "url" {
  value = google_cloud_run_service.svc.status[0].url
}
