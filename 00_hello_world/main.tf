provider "google" {
    region = "us-central1"
    zone   = "us-central1-c"
    #credentials = "c:\..."
    #project = "tf-gcp-student-X"

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
}

// ...
