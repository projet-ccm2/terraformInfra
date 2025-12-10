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
