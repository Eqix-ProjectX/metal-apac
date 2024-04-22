terraform {
  required_providers {
    equinix = {
      source = "equinix/equinix"
      version = "1.35.0"
    }
  }
}

module "instance" {
    source           = "./modules/metal_instance"
    nums             = 3
    metro            = "SG"
    operating_system = "ubuntu_20_04"
}  