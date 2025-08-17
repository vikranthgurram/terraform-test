terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "6.15.0"
        }
    }
}

provider "google" {
    credentials = var.credentials
    project = "new-gcp-466623"
    region = "${var.region}"
}


terraform {
    backend "gcs" {
        bucket = "storage_bucket-02"
        prefix = "state-file"
    }
}

resource "google_compute_instance" "gcp-instance01" {
     name = "google-compute"
     machine_type = "e2-medium"
     zone = "us-central1-c"

     boot_disk {
        initialize_params {
        image = "debian-cloud/debian-11"
        size =20
        }
     }

     network_interface {
        network = "default"
     }
}

resource "google_compute_network" "my_vpc01" {
    name = "my-vpc101"
    auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "my_subnetwork01" {
    name = "my-subnetwork0101"
    network = google_compute_network.my_vpc.name
    ip_cidr_range = "10.0.0.0/16"
     region = "us-central1"
}

resource "google_compute_firewall" "allow-ssh01" {
    name = "allow-ssh01"
    network = google_compute_network.my_vpc.name

    allow {
        protocol = "tcp"
        ports = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
}





//testing