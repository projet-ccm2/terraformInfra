resource "google_sql_database_instance" "db" {
  name             = var.instance_name
  project          = var.project_id
  region           = var.region

  database_version = var.database_version

  settings {
    tier = var.tier
    ip_configuration { 
      ipv4_enabled = false
      private_network = var.private_network
    }
    backup_configuration { enabled = true }
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
