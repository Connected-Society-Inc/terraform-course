resource "google_compute_instance" "instance" {

    name         = "terraform-instance"
    machine_type = "f1-micro"
    zone         = "us-central1-c"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    network_interface {
        network = "default"
        access_config {} 
    }

    // We add a public key to be able to log in to the server via SSH
    metadata = {
        ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
    }

    provisioner "remote-exec" {
        inline = ["echo 'Hello from Provisioner!' >> /etc/motd"]
        # you can tell when provisioner should run
        # when = destroy
        
        connection {
            type        = "ssh"
            host        = self.network_interface[0].access_config[0].nat_ip
            user        = "root"
            private_key = file("~/.ssh/id_rsa")
        }
    }

    // metadata_startup_script = "echo 'Hello from startup script!' >> /etc/motd"

}

resource "null_resource" "null_resource_example" {

    provisioner "local-exec" {
        command = "echo 'Hello world!'"
        when    = destroy
    }
    
}


output "public_ip" {
    value = google_compute_instance.instance.network_interface[0].access_config[0].nat_ip
}
