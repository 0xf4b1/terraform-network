locals {
  alpines = local.devices["alpine"]
}

resource "vsphere_virtual_machine" "alpine" {
  count = length(local.alpines)

  name             = "${var.namespace}-${local.alpines[count.index].name}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 1
  memory   = 512
  guest_id = "other4xLinux64Guest"
  firmware = "efi"

  disk {
    label = "disk"
    size  = 1
  }

  cdrom {
    datastore_id = "${data.vsphere_datastore.datastore.id}"
    path         = "iso/alpine-virt-3.9.0-x86_64.iso"
  }

  dynamic "network_interface" {
    for_each = local.alpines[count.index].vlan_ids

    content {
      network_id = network_interface.value
    }
  }

  wait_for_guest_net_timeout = 0
  wait_for_guest_net_routable = false

  depends_on = [
    vsphere_host_port_group.pg
  ]
}

