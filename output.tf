output "public_address" {
  value = "${google_compute_address.bastion.address}"
}

output "instance_address" {
  value = "${google_compute_instance.bastion.network_interface.0.access_config.0.assigned_nat_ip}"
}
