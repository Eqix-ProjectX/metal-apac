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
    project_id       = "97a6861a-3a9c-4816-9771-aabcc5249581"
    nums             = 3
    metro            = ""
    operating_system = "ubuntu_20_04"
}  