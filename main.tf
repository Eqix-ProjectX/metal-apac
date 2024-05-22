terraform {
  required_providers {
    equinix = {
      source = "equinix/equinix"
      version = "1.35.0"
    }
  }
  cloud {
    organization = "EQIX_projectX"

    workspaces {
      name = "metal-apac"
    }
  }
}

module "instance" {
    source           = "./modules/metal_instance"
    project_id       = ""
    nums             = 3
    metro            = ""
    operating_system = "ubuntu_20_04"
}  
