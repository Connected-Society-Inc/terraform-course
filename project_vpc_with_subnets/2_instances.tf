/*
  Task 2: Provision one compute instance in each subnet configured

        key: "subnet-private" = value: {            
            cidr_block = "10.0.1.0/24"
            public     = false
        },

    subnets = { key->value, key->value, ...
 }

*/


resource "google_compute_instance" "instances" {

    // iterated over the { subnet names -> subnet config }
    for_each = var.subnets
    
    # TODO: set a unique name for the instance
    name = "${each.key}-vm"
    # cidr block of the subnet: each.value.cidr_block

    machine_type = "f1-micro"
    zone         = "us-central1-c"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        // TODO: set the subnetwork. We want exactly one instance per subnet!
        subnetwork = google_compute_subnetwork.subnets[each.key].self_link

        # TODO: if the subnet is configured as public, you should add a nat ip to the instance
        # by defining an empty access_config {} block
        dynamic "access_config" {
            for_each = each.value["public"] ? [1] : []
            content { }
        }
    }

    // We add a public key to be able to log in to the server via SSH
    metadata = {
        ssh-keys = "root:${file(var.public_key)}"
    }

    # TODO: you should assign tag "public" is the instance is in a public subnet
    # you should assign tag "private" otherwise
    # tags will be used to set up firewal rules
    tags = []
}

output "ip_mapping" {
    # TODO: we would like to see all the IP address assignments for each node
    # Expected output:
    /*
        ip_mapping = {
        "subnet-private" = {
            "private_ip" = "10.0.1.2"
            "public_ip" = "no public if"
        }
        "subnet-public" = {
            "private_ip" = "10.0.2.2"
            "public_ip" = "34.123.166.16"
        }
        }

        // private_ip: google_compute_instance.instances["subnet-public"].network_interface[0].network_ip
        // public_ip: google_compute_instance.instances["subnet-public"].network_interface[0].access_config[0].nat_ip

    */
    
    value = { for subnet_name, instance in google_compute_instance.instances: 
        subnet_name => {
            "private_ip" = instance.network_interface[0].network_ip
            "public_ip" = length(instance.network_interface[0].access_config) > 0 ? instance.network_interface[0].access_config[0].nat_ip : "no public if"
        }
    }
}
