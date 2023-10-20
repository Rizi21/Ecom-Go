# Define the subnets, 3 to be created. 1 public and 2 private (App & DB)

# Public subnet 
resource "google_compute_subnetwork" "europe-west2-public" {
  name          = "${var.name}-public"
  region        = var.region
  network       = google_compute_network.my_vpc.name
  ip_cidr_range = "10.0.1.0/24"
}
# Private subnet for the application
resource "google_compute_subnetwork" "europe-west2-app" {
  name          = "${var.name}-app-private"
  region        = var.region
  network       = google_compute_network.my_vpc.name
  ip_cidr_range = "10.0.2.0/24"
}
# Private subnet for the Databases
resource "google_compute_subnetwork" "europe-west2-db" {
  name          = "${var.name}-db-private"
  region        = var.region
  network       = google_compute_network.my_vpc.name
  ip_cidr_range = "10.0.3.0/24"
}