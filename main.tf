
// Create bastion instance
resource "google_compute_instance" "bastion" {
  name          = "bastion"
  description   = "Bastion/jump host for private network access (SSH only)"

  machine_type  = "f1-micro"
  zone          = "${var.region_zone}"
  tags          = ["bastion", "security"]

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    image = "centos-7"
  }

  network_interface {
    network = "default"

    access_config {
      // Bind public static IP we reserved to the bastion
      nat_ip = "${google_compute_address.bastion.address}"
    }
  }

  service_account {
    scopes = [
      "userinfo-email",
      "compute-ro",
      "storage-ro"
    ]
  }
}

// Reserve static external IP bastion
resource "google_compute_address" "bastion" {
  name = "ip-bastion"
}
