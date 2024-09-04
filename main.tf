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
  project_id        = var.project_id
  vlan_desc_pri     = var.vlan_desc_pri
  vlan_desc_sec     = var.vlan_desc_sec
  range_desc_pri    = var.range_desc_pri
  range_desc_sec    = var.range_desc_sec
  cidr              = var.cidr
  network_range_pri = var.network_range_pri
  network_range_sec = var.network_range_sec
}

resource "equinix_metal_port_vlan_attachment" "pri" {
  count     = var.nums
  device_id = module.instance.id[count.index]
  port_name = "bond0"
  vlan_vnid = module.mg2ne.vlan
  depends_on = [ equinix_metal_port.bond ]
}
resource "equinix_metal_port_vlan_attachment" "sec" {
  count     = var.nums
  device_id = module.instance.id[count.index]
  port_name = "bond0"
  vlan_vnid = module.mg2ne.vlan_sec
  depends_on = [ equinix_metal_port.bond ]
}
resource "equinix_metal_port" "bond" {
  port_id  = local.bond0
  layer2   = false
  bonded   = true
  vlan_ids = [
    module.mg2ne.vlan,
    module.mg2ne.vlan_sec
  ]  
}
resource "equinix_metal_device_network_type" "hybrid" {
  device_id = module.instance.id[count.index]
  type = "hybrid-bonded"
}

# resource "equinix_metal_port" "sec" {
#   port_id  = local.bond0_sec
#   layer2   = false
#   bonded   = true
#   vlan_ids = [module.mg2ne.vlan_sec]
# }

# locals {
#   bond0_port_id = ([
#     for p in module.instance.bond_0.*: p.id
#     if p.name == "bond0"
#   ])[0]
# }

locals {
  bond0 = flatten([
    for s in module.instance.bond_0 : [
      for p in s : p.id if p.name == "bond0"
    ]
  ])[0]
  # bond0_sec = flatten([
  #   for s in module.instance.bond_0 : [
  #     for p in s : p.id if p.name == "bond0"
  #   ]
  # ])[1]
}
# output "port_id" {
#   value = local.bond0_port_id
# }