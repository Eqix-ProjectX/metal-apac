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
  source            = "github.com/Eqix-ProjectX/terraform-equinix-mg2ne_connector/"
  metro             = var.metro
  vrf_desc_pri      = var.vrf_desc_pri
  vrf_desc_sec      = var.vrf_desc_sec
  vrf_name_pri      = var.vrf_name_pri
  vrf_name_sec      = var.vrf_name_sec
  vrf_asn           = var.vrf_asn
  vrf_ranges_pri    = var.vrf_ranges_pri
  vrf_ranges_sec    = var.vrf_ranges_sec
  project_id        = var.project_id
  vlan_desc_pri     = var.vlan_desc_pri
  vlan_desc_sec     = var.vlan_desc_sec
  range_desc_pri    = var.range_desc_pri
  range_desc_sec    = var.range_desc_sec
  cidr              = var.cidr
  network_range_pri = var.network_range_pri
  network_range_sec = var.network_range_sec
}