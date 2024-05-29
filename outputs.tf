output "hostname_instance" {
  value = module.instance.hostname
}
output "instance_id" {
  value = module.instance.id
}
output "instance_pip" {
  value = module.instance.pip
}
output "hostname_vd" {
  value = module.ne.hostname_vd
}
output "hostname_vd_sec" {
  value = module.ne.hostname_vd_sec
}
output "ssh_ip_vd" {
  value = module.ne.ssh_ip_vd
}
output "ssh_ip_vd_sec" {
  value = module.ne.ssh_ip_vd_sec
}