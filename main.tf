terraform {
  required_providers {
    equinix = {
      source = "equinix/equinix"
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
  source         = "github.com/Eqix-ProjectX/terraform-equinix-mg2ne_connector/"
  metro          = var.metro
  vrf_desc       = var.vrf_desc
  vrf_desc_sec   = var.vrf_desc_sec
  vrf_name       = var.vrf_name
  vrf_name_sec   = var.vrf_name_sec
  vrf_asn        = var.vrf_asn
  vrf_ranges     = var.vrf_ranges
  vrf_ranges_sec = var.vrf_ranges_sec
  project_id     = var.project_id
  vlan_desc      = var.vlan_desc
  vlan_desc_sec  = var.vlan_desc_sec
  range_desc     = var.range_desc
  range_desc_sec = var.range_desc_sec
  cidr           = var.cidr
  network_range  = var.network_range
}