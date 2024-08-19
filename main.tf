terraform {
  required_providers {
    equinix = {
      source  = "equinix/equinix"
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
  source           = "github.com/Eqix-ProjectX/terraform-equinix-metal-instance/"
  project_id       = var.project_id
  billing_cycle    = var.billing_cycle
  plan             = var.plan
  nums             = var.nums
  metro            = var.metro
  operating_system = var.operating_system
}

module "mg2ne" {
  source        = "github.com/Eqix-ProjectX/terraform-equinix-mg2ne_connector/"
  metro         = var.metro
  vrf_desc      = var.vrf_desc
  vrf_name      = var.vrf_name
  vrf_asn       = var.vrf_asn
  vrf_ranges    = var.vrf_ranges
  project_id    = var.project_id
  vlan_desc     = var.vlan_desc
  range_desc    = var.range_desc
  cidr          = var.cidr
  network_range = var.network_range
}