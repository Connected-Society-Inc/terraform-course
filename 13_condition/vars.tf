variable "vpc_name" {
    type = string
    description = "VPC name"
    // default = "terraform-vpc"
}

# list lengths determine how many subnets we will have
variable "subnets" {
    description = "Subnet configuration"
    // default = ["10.0.1.0/24", "10.0.2.0/24"]
    type = list(string)
}

variable "instance_names" {
    type = list(string)
    description = "Name of the instances"
}

variable "create_instances" {
    type = bool
    description = "Do you want to have instances in your subnets?"
    default = true
}
