locals {
  project_id = "d0418d98-86af-417a-a50a-331c989ffe63"
}

resource "equinix_metal_device" "metal" {
  count            = var.nums
  hostname         = "metal-apac-node${count.index + 1}"
  plan             = var.plan
  metro            = var.metro
  operating_system = var.operating_system
  billing_cycle    = var.billing_cycle
  project_id       = local.project_id
}

