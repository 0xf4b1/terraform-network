locals {
  types = distinct([var.network.*.type])
  devices = {
    for type in local.types:
    type => [for device in var.network: device if device.type == type]
  }
}

