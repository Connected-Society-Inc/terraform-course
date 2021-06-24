# TODO: place one instance in each subnet (created by count!)
resource "google_compute_instance" "instance" {

    name = vars.instance_name
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        subnetwork = google_compute_subnetwork.subnet.id
    }
}

