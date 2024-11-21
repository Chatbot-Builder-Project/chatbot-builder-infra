variable "name" {
  type        = string
  description = "Public IP name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "domain_name_label" {
  type        = string
  description = "DNS label for the public IP"
  default     = null
}