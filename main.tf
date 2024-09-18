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

locals {
  gw_ip_pri = cidrhost("${module.mg2ne.network_range_pri}/${var.cidr}", 1)
  gw_ip_sec = cidrhost("${module.mg2ne.network_range_sec}/${var.cidr}", 1)
  ssh_private_key = base64decode(var.private_key)
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
}
resource "equinix_metal_port_vlan_attachment" "sec" {
  count     = var.nums
  device_id = module.instance.id[count.index]
  port_name = "bond0"
  vlan_vnid = module.mg2ne.vlan_sec
}

/*
resource "local_file" "netplan" {
  count = var.nums
  content = <<-EOT
    #!/bin/bash
    sudo cat << EOF > /etc/netplan/00-netcfg.yaml
    network:
      version: 2
      renderer: networkd
      ethernets:
        enp1s0f0np0: {}
        enp1s0f1np1: {}
      bonds:
        bond0:
          interfaces:
            - enp1s0f0np0
            - enp1s0f1np1
          addresses: []
          parameters:
            mode: active-backup
            primary: bond0
      vlans:
        bond0.${module.mg2ne.vlan}:
          id: ${module.mg2ne.vlan}
          link: bond0
          addresses:
            - ${cidrhost("${local.gw_ip_pri}/${var.cidr}", count.index + 2)}/${var.cidr}
          dhcp4: no
        bond0.${module.mg2ne.vlan_sec}:
          id: ${module.mg2ne.vlan_sec}
          link: bond0
          addresses:
            - ${cidrhost("${local.gw_ip_sec}/${var.cidr}", count.index + 2)}/${var.cidr}
          dhcp4: no
    EOF
    sudo systemctl restart system-networkd
  EOT
  filename = "netplan${count.index}.sh"
}
*/

resource "null_resource" "int_ip" {
  count = var.nums
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = local.ssh_private_key
      host        = module.instance.pip[count.index]
    }

    inline = [
      "sudo ip link add link bond0 name bond0.${module.mg2ne.vlan} type vlan id ${module.mg2ne.vlan}",
      "sudo ip link add link bond0 name bond0.${module.mg2ne.vlan_sec} type vlan id ${module.mg2ne.vlan_sec}",
      "sudo ip addr add ${cidrhost("${local.gw_ip_pri}/${var.cidr}", count.index + 2)}/${var.cidr} dev bond0.${module.mg2ne.vlan}",
      "sudo ip addr add ${cidrhost("${local.gw_ip_sec}/${var.cidr}", count.index + 2)}/${var.cidr} dev bond0.${module.mg2ne.vlan_sec}",
      "sudo ip link set bond0.${module.mg2ne.vlan} up",
      "sudo ip link set bond0.${module.mg2ne.vlan_sec} up",
      "sudo ip route add ${var.network_range_pri}/24 via ${local.gw_ip_pri} dev bond0.${module.mg2ne.vlan}",
      "sudo ip route add ${var.network_range_sec}/24 via ${local.gw_ip_sec} dev bond0.${module.mg2ne.vlan_sec}"
    ]

    # script = "netplan${count.index}.sh"
  }
}