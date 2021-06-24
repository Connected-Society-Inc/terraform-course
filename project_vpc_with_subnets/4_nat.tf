/*
  Task 4: Set up a NAT instance to allow outbound internet access for instances running inside a private subne
*/

/*resource "google_compute_router" "router" { 
    # TODO: create a router
    # project = 
    # region  = 
    # network = 
    # name    = 
}

resource "google_compute_router_nat" "vpc_nat" {
    # name    =     
    # project = 
    # region  = 
    # router  = 

    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

    # TODO: add a subnetwork {} block for each private subnet as below:
/*    subnetwork {
        # subnetwork name
        name = 
        source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }

    subnetwork {
        # subnetwork name
        name = 
        source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }

}*/
