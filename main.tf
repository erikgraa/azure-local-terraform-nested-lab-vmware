
locals {
  annotation = "Azure Local nested deployment."
  num_cpus   = 12
  memory     = 65536
  os_disk    = 200
  data_disk  = 500
  #guest_id         = "windows2022srvNext-64"
  guest_id         = "windows2019srvNext_64Guest"
  hardware_version = 21
  firmware         = "efi"
}

data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "azure_local_vm" {
  for_each         = toset(var.azure_local_nodes)
  annotation       = local.annotation
  name             = each.key
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = local.num_cpus
  memory           = local.memory
  guest_id         = local.guest_id
  firmware         = local.firmware
  vtpm {
    version = "2.0"
  }
  vbs_enabled             = true
  vvtd_enabled            = true
  nested_hv_enabled       = true
  efi_secure_boot_enabled = true
  hardware_version        = local.hardware_version
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }
  disk {
    label            = "Hard Disk 1"
    size             = local.os_disk
    thin_provisioned = true
    unit_number      = 0
  }
  disk {
    label            = "Hard Disk 2"
    size             = local.data_disk
    thin_provisioned = true
    unit_number      = 1
  }
  disk {
    label            = "Hard Disk 3"
    size             = local.data_disk
    thin_provisioned = true
    unit_number      = 2
  }
  wait_for_guest_ip_timeout  = 0
  wait_for_guest_net_timeout = 0
}