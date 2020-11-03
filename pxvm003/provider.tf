terraform {
  required_providers {
    proxmox = {
      source  = "registry.example.com/telmate/proxmox"
      version = ">=1.0.0"
    }
  }
  required_version = ">= 0.13"
}

provider "proxmox" {
    pm_api_url = "https://192.168.12.1:8006/api2/json"
    pm_user = "root@pam"
    pm_password = "pass"
    pm_tls_insecure = true
}
