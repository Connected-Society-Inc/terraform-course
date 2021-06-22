output "instance_id" {
    value = google_compute_instance.instance.instance_id
}

output "instance_ip" {
    value = google_compute_instance.instance.network_interface[0].access_config[0].nat_ip
}
