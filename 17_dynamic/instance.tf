# TODO: have only one instance, but it should have a dedicated network interface for each subnets created
resource "google_compute_instance" "instance" {

    name = "instance"
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    /* To have N number of network_interfaces we have to use "dynamic"
    network_interface {
        subnetwork = "subnet1"
    }

    network_interface {
        subnetwork = "subnet2"
    } 
    */   

    dynamic "network_interface" {
        for_each = toset(google_compute_subnetwork.subnets)
        iterator = it
        content {
            network    = var.vpc_name
            subnetwork = it.key.id
        }
    }

}
