provider "google" {
    zone   = "us-central1-c"
}

# Task: populate the public key (id_rsa.pub) as a new secret to Secret Manager
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version

locals {
    ssh_key = file("./id_rsa.pub")
}

resource "google_secret_manager_secret" "secret" {
    secret_id = "my-terraform-secret"
    replication {
      automatic = true
    }
}

resource "google_secret_manager_secret_version" "secret_version" {
    secret = google_secret_manager_secret.secret.id
    secret_data = local.ssh_key
}
