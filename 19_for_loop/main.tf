provider "google" {
    zone   = "us-central1-c"
}

locals {
    names = ["bob", "john", "adam"]
}

// generates an output as a terraform map
output "names_uppercase" {
    value = { for name in local.names: name => upper(name) }
}

// generates an output as a terraform list
output "names_uppercase_list" {
    value = [ for name in local.names: upper(name) ]
}

// filter specific elements out
output "names_filtered" {
    value = [ for name in local.names: name if length(name) > 3 ]
}

resource "google_compute_instance" "instances" {

    count = 3
    name = "i-${count.index}"
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        network = "default"
        access_config { }
    }
}

output "public_ips" {
    value = [ for i in google_compute_instance.instances: i.network_interface[0].access_config[0].nat_ip ]
}
