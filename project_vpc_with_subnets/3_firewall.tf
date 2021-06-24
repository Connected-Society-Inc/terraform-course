/*
  Task 3: Set up firewall
*/


# Firewall rule for public subnets. We allow traffic for everywhere towards public instances
/*resource "google_compute_firewall" "public_allow_all_inbound" {
    # TODO: set name and network
    # name      = 
    # network   = 
    
    direction     = "INGRESS"
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["public"]
    
    priority = "1000"

    allow {
        protocol = "all"
    }
}

# Firewall rule for private subnets. We allow traffic just from the public subnets
resource "google_compute_firewall" "private_allow_local_inbound" {
    # TODO: set name and network
    # name      = 
    # network   = 
    
    direction     = "INGRESS"
    # TODO: source ranges is a list of cidrs block. You should list all the cidr blocks assinged to a public subnets
    # source_ranges = []
    target_tags   = ["private"]
    
    priority = "1000"

    allow {
        protocol = "all"
    }
}*/
