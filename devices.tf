locals {
  devices = {
    for type in distinct(flatten([var.network.*.type])):
    type => [for device in var.network: device if device.type == type]
  }
}

