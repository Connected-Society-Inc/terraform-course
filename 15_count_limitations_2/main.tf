provider "google" {
    zone   = "us-central1-c"
}

locals {
    instance_names = ["xinstance-1", "xinstance-2", "xinstance-3"]
}
/* Effect of removing xinstance-2 from the list above
I1
I2 [restarted + renamed to I3]
I3 [X]
*/

resource "google_compute_instance" "instance" {

    count = length(local.instance_names)
    
    name = local.instance_names[count.index]
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
