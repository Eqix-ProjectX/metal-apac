/*data "equinix_network_account" "pre" {
  metro_code = var.metro_code
  status     = "Active" 
}

data "equinix_network_account" "sec" {
  metro_code = var.sec_metro_code
  status     = "Active"
}
*/

resource "equinix_network_device" "c8kv-ha" {
  name              = "vd-${var.metro_code}-vnf-pre"
  metro_code        = var.metro_code
  type_code         = var.type_code
  self_managed      = true
  byol              = true
  package_code      = var.package_code
  notifications     = var.notifications
  hostname          = "vd-${var.metro_code}-vnf-pre"
  term_length       = 12
  account_number    = var.account_number
  version           = var.ver
  core_count        = var.core_count
  acl_template_id   = var.acl_template_id
  secondary_device {
    name            = "vd-${var.sec_metro_code}-vnf-sec"
    metro_code      = var.sec_metro_code
    hostname        = "vd-${var.sec_metro_code}-vnf-sec"
    notifications   = var.notifications
    account_number  = var.sec_account_number
    acl_template_id   = var.acl_template_id
  }
  ssh_key {
    username        = var.username
    key_name        = var.key_name
  }
}