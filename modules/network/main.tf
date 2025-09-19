resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.network_name}-subnet"
  ip_cidr_range = var.cidr_block
  region        = "europe-west1"
  network       = google_compute_network.vpc.id
  private_ip_google_access = true
}

// Reserved range for Private Service Connect (Cloud SQL Private IP)
resource "google_compute_global_address" "psa_range" {
  name          = "${var.network_name}-psa"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

// Establish private services connection for the VPC
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.psa_range.name]
}

resource "google_vpc_access_connector" "connector" {
  name          = "${var.network_name}-conn"
  region        = "europe-west1"
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.8.0.0/28"
  min_instances = 2
  max_instances = 3
}
