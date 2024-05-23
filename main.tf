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
    project_id       = var.project_id
    billing_cycle    = var.billing_cycle
    plan             = var.plan
    nums             = var.nums
    metro            = var.metro
    operating_system = var.operating_system
}  