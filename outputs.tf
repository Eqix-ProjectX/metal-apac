output "hostname_instance" {
  value = module.instance.hostname
}
output "instance_id" {
  value = module.instance.id
}
output "instance_pip" {
  value = module.instance.pip
}
output "vrf_pri" {
  value = equinix_metal_vrf.myvrf_pri.id
}
output "vrf_sec" {
  value = equinix_metal_vrf.myvrf_sec.id
}
output "vrf_ranges" {
  value = module.mg2ne.vrf_ranges[*]
}
output "vrf_ranges_sec" {
  value = module.mg2ne.vrf_ranges_sec[*]
}
output "cidr" {
  value = module.mg2ne.cidr
}
output "network_range_pri" {
  value = module.mg2ne.network_range_pri
}
output "network_range_sec" {
  value = module.mg2ne.network_range_sec
}
output "vrf_asn" {
  value = module.mg2ne.vrf_asn
}
output "vlan_pri" {
  value = module.mg2ne.vlan
}
output "vlan_sec" {
  value = module.mg2ne.vlan_sec
}
output "connection_name" {
  value = equinix_metal_connection.mg2vd.name
}
output "port_pri" {
  value = equinix_metal_connection.mg2vd.ports[0].id
}
output "port_sec" {
  value = equinix_metal_connection.mg2vd.ports[1].id
}