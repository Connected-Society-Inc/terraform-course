terraform {
    backend "gcs" {
        // remote state "storage" configuration
        bucket = "terraform_state_89rwejhay3"
    }
}