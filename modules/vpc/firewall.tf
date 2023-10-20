# Define firewall rules to allow necessary traffic
resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "all"
  }

  source_ranges = [
      google_compute_subnetwork.europe-west2-app.ip_cidr_range,
      google_compute_subnetwork.europe-west2-db.ip_cidr_range,
    ]
}

resource "google_compute_firewall" "allow-external" {
  name    = "allow-external"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "5432", "3307"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allow traffic from all source IP addresses
}