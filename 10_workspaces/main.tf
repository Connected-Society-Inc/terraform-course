provider "google" {
    zone   = "us-central1-c"
}

variable instance_name {   
    type = string
    description = "Name of the instance"
    default = "instance"
}

# resource <resource_type> <internal_resource_id> { ... properties ... }
resource "google_compute_instance" "instance" {

    name = var.instance_name
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        network = "default"
    }
}


// ...
