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
  source             = "github.com/Eqix-ProjectX/terraform-equinix-metal-instance/"
  project_id         = var.project_id
  billing_cycle      = var.billing_cycle
  plan               = var.plan
  nums               = var.nums
  metro              = var.metro
  operating_system   = var.operating_system
}

module "ne" {
  source             = "github.com/Eqix-ProjectX/terraform-equinix-networkedge-vnf/"
  core_count         = var.core_count
  metro_code         = var.metro_code
  notifications      = var.notifications
  package_code       = var.package_code
  account_number     = var.account_number
  sec_account_number = var.sec_account_number
  sec_metro_code     = var.sec_metro_code
  type_code          = var.type_code
  ver                = var.ver
  username           = var.username
  key_name           = var.key_name
  acl_template_id    = var.acl_template_id
}

# netmiko portion
data "equinix_network_device" "vd_pri" {
  name = "vd-${var.metro_code}-${var.username}-pre"

  depends_on = [ module.ne ]
}
data "equinix_network_device" "vd_sec" {
  name = "vd-${var.sec_metro_code}-${var.username}-sec"

  depends_on = [ module.ne ]
}
data "equinix_metal_device" "instance" {
  project_id = var.project_id
  device_id  = "metal-${var.metro}-node-1}"

  depends_on = [ module.instance ]
}
locals {
  config = <<-EOF
  from netmiko import ConnectHandler

  pri = {
    'device_type': 'cisco_xe',
    'host'       : '${data.equinix_network_device.vd_pri.ssh_ip_address}',
    'username'   : '${var.username}',
    'password'   : '${data.equinix_network_device.vd_pri.vendor_configuration.adminPassword}'
  }

  sec = {
    'device_type': 'cisco_xe',
    'host'       : '${data.equinix_network_device.vd_sec.ssh_ip_address}',
    'username'   : '${var.username}',
    'password'   : '${data.equinix_network_device.vd_sec.vendor_configuration.adminPassword}'
  }

  ha = [pri, sec]

  for i in ha:
    net_connect = ConnectHandler(**i)
    config_commands = [
      'ip http secure-server',
      'restconf'
    ]
    output = net_connect.send_config_set(config_commands)
    print(output)
  EOF
}

resource "null_resource" "cisco" {
  provisioner "remote-exec" {
    connection {
      type           = "ssh"
      user           = "root"
      private_key    = var.private_key
      host           = data.equinix_metal_device.instance.access_public_ipv4
    }
    
    inline = [
      "apt install python3-pip -y",
      "y",
      "pip install netmiko",
      "y",
      "cat << EOF > ~/restconf.py\n${local.config}\nEOF",
      "python3 restconf.py"
    ]    
  }
}