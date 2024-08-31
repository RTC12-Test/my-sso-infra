terraform {
  required_providers {
    tss = {
      source  = "DelineaXPM/tss"
      version = "2.0.6"
    }
  }
}

# Calls config path
provider "tss" {
  username   = var.delinea_username
  password   = var.delinea_password
  server_url = var.delinea_server_url
}
