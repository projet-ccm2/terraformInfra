output "database_instance_name" {
  value = google_sql_database_instance.main.name
}

output "private_ip_address" {
  value = google_sql_database_instance.main.server_ca_cert[0].cert
}