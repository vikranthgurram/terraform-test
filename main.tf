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

resource "google_compute_instance" "gcp-instance" {
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

resource "google_compute_network" "my_vpc" {
    name = "my-vpc1"
    auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "my_subnetwork" {
    name = "my-subnetwork01"
    network = google_compute_network.my_vpc.name
    ip_cidr_range = "10.0.0.0/16"
     region = "us-central1"
}

resource "google_compute_firewall" "allow-ssh" {
    name = "allow-ssh"
    network = google_compute_network.my_vpc.name

    allow {
        protocol = "tcp"
        ports = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_network" "my_vpctesting" {
    name = "vic-test"
    auto_create_subnetworks = false
}