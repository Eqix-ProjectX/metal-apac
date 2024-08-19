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
variable "vrf_desc" {}
variable "vrf_name" {}
variable "vrf_asn" {}
variable "vrf_ranges" {}
variable "vlan_desc" {}
variable "range_desc" {}
variable "cidr" {}
variable "network_range" {}