provider "google" {
    zone   = "us-central1-c"
}

data "google_secret_manager_secret_version" "ssh_key" {
    secret = "terraform-ssh-key"
}

# resource <resource_type> <internal_resource_id> { ... properties ... }
# Provision a GCP Compute Engine instance with a public ip address
# to have access from outside
# Link to doc of the resource: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
resource "google_compute_instance" "instance" {

    # name = "terraform-instance"
    name         = "terraform-secret"
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        network = "default"
        access_config {
          // if you leave this block empty => ephemeral ip will be generated
        }
    }

    metadata = {
      "ssh-keys" = "root:${data.google_secret_manager_secret_version.ssh_key.secret_data}"
    }
}

output "public_ip" {
    value = google_compute_instance.instance.network_interface[0].access_config[0].nat_ip
}

output "my_secret" {
    sensitive = true
    value = data.google_secret_manager_secret_version.ssh_key.secret_data
}
