provider "google" {
    zone   = "us-central1-c"
}

resource "google_compute_instance" "instance" {

    name = "production-instance"
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        network = "default"
    }

    // meta-argument
    lifecycle {
      create_before_destroy = true
    }
}
