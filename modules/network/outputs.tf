output "network_name" {
  value = google_compute_network.vpc.name
}
output "subnet_name"  {
  value = google_compute_subnetwork.subnet.name
}
output "subnet_cidr"  {
  value = google_compute_subnetwork.subnet.ip_cidr_range
}
output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}
output "vpc_connector_id" {
  value       = google_vpc_access_connector.serverless.id
  description = "ID du connecteur VPC pour Cloud Run / Cloud Functions"
}
output "vpc_connector_name" {
  value = google_vpc_access_connector.serverless.name
}
