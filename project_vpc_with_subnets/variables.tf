variable "project" {
    description = "Project ID for the network"
    type        = string
}

variable "name_prefix" {
    description = "Prefix for the network name"
    type        = string
}

variable "region" {
    description = "Region to deploy VPC and its subnets"
    type        = string
    default     = "us-central1"
}

variable "public_key" {
    description = "Location of a public key file for SSH access"
    type        = string
    default     = "~/.ssh/id_rsa.pub"
}

variable "subnets" {
    description = "List of subnet definitions"
    type        = map(object({
        cidr_block = string
        public     = bool
    }))
    default = {
        "subnet-private" = {            
            cidr_block = "10.0.1.0/24"
            public     = false
        },
        "subnet-public" = {
            cidr_block = "10.0.2.0/24"
            public     = true
        }
    }
}
