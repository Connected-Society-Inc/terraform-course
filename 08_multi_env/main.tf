provider "google" {
    zone   = "us-central1-c"
}

# resource <resource_type> <internal_resource_id> { ... properties ... }
resource "google_compute_instance" "instance" {

    name = "instance-by-terraform"
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        network = "default"
    }

    labels = {
        "project" = "terraform-course"
    }
 
}

resource "google_compute_instance" "imported_instance" {
    name = "instance-1"
    machine_type = "e2-medium"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        network = "default"
        access_config {
          network_tier = "PREMIUM"          
        }
    }

    reservation_affinity {
      type = "ANY_RESERVATION"
    }

    allow_stopping_for_update = true

}
// ...
