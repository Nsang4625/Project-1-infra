output "master_ip" {
  value = google_compute_instance.master_instance.network_interface.0.access_config.0.nat_ip
}
