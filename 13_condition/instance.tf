# TODO: just create instances if var.create_instances == true
# var.create_instances ? "let's create instances" : "no instances"
resource "google_compute_instance" "instance" {

    # <expression> ? <return on true> : <return on false>
    count = var.create_instances ? length(var.subnets) : 0

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

