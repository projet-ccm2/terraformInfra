output "vpc_self_link" {
  value = google_compute_network.vpc_network.self_link
}

output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}

output "subnet_region" {
  value = google_compute_subnetwork.subnet.region
}