output "hostname_instance" {
  value = module.instance.hostname
}
output "instance_id" {
  value = module.instance.id
}
output "instance_pip" {
  value = module.instance.pip
}
output "vrf_ranges" {
  value = module.mg2ne.vrf_ranges[*]
}
output "cidr" {
  value = module.mg2ne.cidr
}
output "network_range" {
  value = module.mg2ne.network_range
}
output "vrf_asn" {
  value = module.mg2ne.vrf_asn
}
output "vlan" {
  value = module.mg2ne.vlan
}