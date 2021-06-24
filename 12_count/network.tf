provider "google" {
    region = "us-central1"
    zone   = "us-central1-c"
}

# VPC
resource "google_compute_network" "vpc" {
    name = var.vpc_name
    auto_create_subnetworks = false
}

# Subnet in the VPC
resource "google_compute_subnetwork" "subnet" {

    # meta argument: it is not provider dependent, you can use with any resource
    count = length(var.subnets)

    name          = "terraform-subnet-${count.index}"
    ip_cidr_range = var.subnets[count.index]
    network       = google_compute_network.vpc.id
}
