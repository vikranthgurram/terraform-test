terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "6.15.0"
        }
    }
}

provider "google" {
    credentials = "${{ secrets.CREDENTIALS }}"
    project = "new-gcp-466623"
    region = "us-central1"
}

resource "google_compute_instance" "gcp-instance" {
     name = "google-compute"
     machine_type = "e2.micro"
     zone = "us-central1-a"

     boot_disk {
        initialize_params {
        image = "debian-cloud/debian-11"
        size =20
        }
     }

     network_interface {
        network = default
     }
}