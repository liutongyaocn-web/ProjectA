terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.26"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}
