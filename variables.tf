variable "project_id" {}
variable "plan" {
  type    = string
  default = "c3.small.x86"
}
variable "metro" {}
variable "operating_system" {}
variable "billing_cycle" {
  type    = string
  default = "hourly"
}
variable "nums" {
  type = number
}

variable "private_key" {}
variable "vrf_desc_pri" {}
variable "vrf_desc_sec" {}
variable "vrf_name_pri" {}
variable "vrf_name_sec" {}
variable "vrf_asn" {}
variable "vrf_ranges_pri" {}
variable "vrf_ranges_sec" {}
variable "vlan_desc_pri" {}
variable "vlan_desc_sec" {}
variable "range_desc_pri" {}
variable "range_desc_sec" {}
variable "cidr" {}
variable "network_range_pri" {}
variable "network_range_sec" {}
variable "connection_name" {}
variable "email" {}