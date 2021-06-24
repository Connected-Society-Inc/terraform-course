# TODO: just create instances if var.create_instances == true
# var.create_instances ? "let's create instances" : "no instances"
resource "google_compute_instance" "instance" {

    # <expression> ? <return on true> : <return on false>
    #  ... is equal:
    /*

        var.create_instance ? length(var.subnets) : 0
        ==== 
        if var.create_instance == true
        then
          return length(var.subnets)
        else 
          return 0
    */
   
    # this will return length(var.subnets) if create_instances is true, otherwise will be 0
    count = var.create_instances ? length(var.subnets) : 0

    name = var.instance_names[count.index]
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        subnetwork = google_compute_subnetwork.subnet[count.index].id
    }

}

