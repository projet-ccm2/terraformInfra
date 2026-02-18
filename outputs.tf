output "ar_repo_url" {
  value = module.ar.repo_url
}
output "bucket_name" {
  value = module.bucket.name
}
output "db_conn_name" {
  value = module.db.connection_name
}
output "vpc_network" {
  value = module.vpc_network.vpc_self_link
}
output "vpc_connector_id" {
  value       = module.vpc_network.vpc_connector_id
  description = "Connecteur VPC pour Cloud Run (accès privé à Cloud SQL)"
}
