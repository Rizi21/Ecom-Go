provider "google" {
  project = "riz-go"
}

resource "google_compute_network" "my_vpc" {
    project = "riz-go"
    name = "my-vpc"
}

# Create an IP address
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.my_vpc.id
}

# Create a private connection
resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.my_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}