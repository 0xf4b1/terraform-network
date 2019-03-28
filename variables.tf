# vCenter connection

variable "vsphere_user" {
  description = "vSphere user name"
}

variable "vsphere_password" {
  description = "vSphere password"
}

variable "vsphere_server" {
  description = "vCenter server FQDN or IP"
}

variable "namespace" {
  type = string
}

variable "network" {
  type = list(object({
    name = string
    type = string
    vlan_ids = list(number)
  }))
}
