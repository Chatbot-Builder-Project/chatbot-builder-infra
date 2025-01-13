variable "name" {
  type        = string
  description = "Name of the Azure OpenAI service"
}

variable "location" {
  type        = string
  description = "Azure region for all resources"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to be created for the AKS cluster and associated resources"
}

variable "sku" {
  type        = string
  description = "Pricing tier of the Azure OpenAI service"
  default     = "S0"
}
