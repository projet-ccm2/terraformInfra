resource "google_sql_database_instance" "db" {
  name             = var.instance_name
  project          = var.project_id
  region           = var.region

  database_version = var.database_version

  settings {
    tier = var.tier
    ip_configuration { 
      ipv4_enabled = var.public_ip
      private_network = var.public_ip ? null : var.private_network
      dynamic "authorized_networks" {
        for_each = var.public_ip ? var.authorized_networks : []
        content {
          value = authorized_networks.value
        }
      }
    }
    backup_configuration { 
      enabled                        = var.enable_backups
      point_in_time_recovery_enabled = false
      transaction_log_retention_days = var.enable_backups ? 1 : null
    }
    deletion_protection_enabled = false
    insights_config {
      query_insights_enabled  = false
      query_string_length     = 1024
      record_application_tags = false
      record_client_address   = false
    }
  }
}

resource "google_sql_database" "app" {
  name     = var.db_name
  instance = google_sql_database_instance.db.name
}

resource "google_sql_user" "app" {
  name     = var.db_user
  instance = google_sql_database_instance.db.name
  password = var.db_password
}

output "connection_name" {
  value = google_sql_database_instance.db.connection_name
}
