variable "vsphere_user" {
  type        = string
  ephemeral   = true
  sensitive   = true
  description = "VMware vSphere User."
}

variable "vsphere_password" {
  type        = string
  ephemeral   = true
  sensitive   = true
  description = "VMware vSphere Password."
}

variable "vsphere_server" {
  type        = string
  description = "VMware vSphere Server."
}

variable "azure_local_nodes" {
  type        = list(string)
  description = "Azure Cluster node hostname(s)"
}

variable "datacenter" {
  type        = string
  description = "VMware vSphere datacenter."
}

variable "cluster" {
  type        = string
  description = "VMware vSphere cluster."
}

variable "datastore" {
  type        = string
  description = "VMware vSphere datastore."
}

variable "network" {
  type        = string
  description = "Azure Cluster network in VMware vSphere. Typically a trunk portgroup."
}