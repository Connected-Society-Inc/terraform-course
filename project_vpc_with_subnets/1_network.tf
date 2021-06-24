/*
  Task 1: Create the VPC and the corresponding subnets defined in var.subnets
*/

resource "google_compute_network" "vpc" {
    // TODO: properties to set: name, project
    name    = "${var.name_prefix}-vpc"
    project = var.project
    
    // we will create the subnets manually based on the input config
    auto_create_subnetworks = false
}

// count, for_each, for, dynamic, if
resource "google_compute_subnetwork" "subnets" {

    // TODO: create the subnets based on the var.subnets input
    // properties to set: name, region, network, ip_cidr_range

    for_each = var.subnets

    name    = each.key
    network = google_compute_network.vpc.self_link
    region  = var.region
    
    ip_cidr_range = each.value.cidr_block
}
