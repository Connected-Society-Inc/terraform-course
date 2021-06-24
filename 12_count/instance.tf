# TODO: place one instance in each subnet (created by count!)
resource "google_compute_instance" "instance" {

    count = length(var.subnets)

    name = var.instance_names[count.index]
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        subnetwork = google_compute_subnetwork.subnet[count.index].id
    }
}

