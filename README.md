# terraform-network
Terraform boilerplate code to deploy a configured network topology to ESXi

## Requirements

### Terraform 0.12 (beta)
Terraform 0.12 is required to support for-loops, dynamic-blocks, and complex-objects.
The binary can be downloaded from [here](https://releases.hashicorp.com/terraform/0.12.0-beta1/).

### Terraform vSphere provider (compatible with 0.12)
It also requires a compatible vSphere provider version that needs to be build from source.

- `git clone -b core-v0.12-alpha4 https://github.com/terraform-providers/terraform-provider-vsphere`
- `cd terraform-provider-vsphere`
- `make build`
- copy the output binary `terraform-provider-vsphere` into the same directory as the terraform binary

## Configuration
The `terraform.tfvars` file is the only configuration file that needs to be adjusted. It contains the needed parameters for the ESXi connection and the network topology.

The network topology is a complex-object with the following structure:
```
variable "network" {
  type = list(object({
    name = string
    type = string
    vlan_ids = list(number)
  }))
}
```
It is a list of network objects consisting of a name (arbitrary chosen identifier for the device), a type (device type that maps to the related terraform configuration), and vlan_ids (a list of ids that specifies to which networks the device is connected to).
It is extensible with new device types by creating additional `<device type name>.tf` files.

Without a vCenter installation it is not possible to deploy prebuilt virtual-machine images via cloning, it is only possible to create empty hard-drives and boot from cd-drive to perform an OS installation. Due to this issue there is at the moment only one device type available which is `alpine`, a small linux live image without any persistence.

## Deployment
The deployment is done via the default terraform commands.

`terraform validate` - check for correct syntax

`terraform plan` - display the steps that will be executed according to the current state

`terraform graph  | dot -Tsvg > graph.svg` - export the plan as visual graph

`terraform apply` - apply the plan and do the actual deployment. It will also show the plan and ask for confirmation.

`terraform destroy` - delete everything that was applied before
