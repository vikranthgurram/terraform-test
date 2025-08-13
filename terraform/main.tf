terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "6.15.0"
        }
    }
}

provider "google" {
 credentials = "/Users/saradaganta/Downloads/new-gcp-466623-faaa6b07b2da.json"
}
