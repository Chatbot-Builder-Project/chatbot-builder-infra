variable "name" {
  description = "The name of the storage account"
  type        = string
}

variable "location" {
  description = "The location of the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "container_access_type" {
  description = "The access level to use for the container"
  type        = string
}