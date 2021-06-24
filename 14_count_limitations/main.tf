provider "google" {
    zone   = "us-central1-c"
}

/* instead of this, I'd like to figure out the count "on the fly"
variable instance_count {
    type = number
    description = "Number of instances"
    default = 1
}*/

resource "random_integer" "instance_count" {
    min = 1
    max = 3
}

/*data "google_configuration_store" "instance_count" {
    name = // ....
}*/

resource "google_compute_instance" "instance" {

    // this won't work !!!
    count = random_integer.instance_count.result
    
    name = "instance-${count.index}"
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

