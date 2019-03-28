locals {
  vlans = [0, 1]
}

resource "vsphere_host_virtual_switch" "switch" {
  name           = "vSwitch-${var.namespace}"
  host_system_id = "${data.vsphere_host.host.id}"

  network_adapters = []

  active_nics  = []
  standby_nics = []
}

resource "vsphere_host_port_group" "pg" {
  count               = length(local.vlans)
  name                = "vlan-${local.vlans[count.index]}"
  host_system_id      = "${data.vsphere_host.host.id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.switch.name}"
  vlan_id = local.vlans[count.index]
  depends_on = [
    vsphere_host_virtual_switch.switch
  ]
}

