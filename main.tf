terraform {
  required_providers {
    equinix = {
      source  = "equinix/equinix"
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

module "ne" {
  source = "./modules/networkedge"
  # connectivity    = var.connectivity
  core_count    = var.core_count
  metro_code    = var.metro
  notifications = var.notifications
  package_code  = var.package_code
  account_number = var.account_number
  sec_account_number = var.sec_account_number
  # sec_hostname    = var.sec_hostname
  sec_metro_code = var.sec_metro_code
  # sec_name        = var.sec_name
  # throughput      = var.throughput
  # throughput_unit = var.throughput_unit
  type_code = var.type_code
  ver       = var.ver
}