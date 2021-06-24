provider "google" {
    zone   = "us-central1-c"
}

/*locals {
    // just because for_each supports sets or maps and not list
    instance_names = toset(["xinstance-1", "xinstance-3"])
}*/

locals {
    // key: instance_name -> { "instance_type": "...", "image:" "..."  }
    instance_configuration = {
        "instance_1" = {
            "instance_type" = "f1-micro",
            "image" = "debian-cloud/debian-10"
        },
        "instance_2" = {
            "instance_type" = "e2-medium",
            "image" = "debian-cloud/debian-10"
        }
    }
}

resource "google_compute_instance" "instance" {

    for_each = local.instance_configuration
    
    name = each.key 
    machine_type = each.value.instance_type

    boot_disk {
        initialize_params {
            image = each.value.image
        }
    }

    network_interface {
        network = "default"
    }
}


/*resource "google_compute_instance" "instance" {

    for_each = local.instance_names
    
    name = each.key // instead of instance_names[count.index] -> each.key
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        network = "default"
    }
}*/


// ...
