variable "cluster_name" {
  type        = string
  description = "AKS cluster name"
}

variable "location" {
  type        = string
  description = "Azure region for AKS"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for AKS"
}

variable "node_count" {
  type        = number
  default     = 1
  description = "Number of nodes in the AKS cluster"
}

variable "vm_size" {
  type        = string
  default     = "Standard_DS2_v2"
  description = "VM size for AKS nodes"
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster"
}

variable "load_balancer_public_ip_ids" {
  type = list(string)
  description = "List of Public IP resource IDs to associate with the AKS load balancer"
  default = []
}