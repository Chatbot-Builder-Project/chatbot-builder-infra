################################################
# Azure credentials
# Generate them using the Azure CLI: az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription_id>"
# Then save them as environment variables in terraform cloud with the following names:
variable "ARM_CLIENT_ID" {
  type        = string
  description = "Azure client ID"
}

variable "ARM_CLIENT_SECRET" {
  type        = string
  description = "Azure client secret"
}

variable "ARM_SUBSCRIPTION_ID" {
  type        = string
  description = "Azure subscription ID"
}

variable "ARM_TENANT_ID" {
  type        = string
  description = "Azure tenant ID"
}
################################################

variable "resource_group_name" {
  type        = string
  default     = "chatbot-builder-rg"
  description = "Name of the resource group to be created for the AKS cluster and associated resources"
}

variable "location" {
  type        = string
  default     = "israelcentral"
  description = "Azure region for all resources"
}

variable "cluster_name" {
  type        = string
  default     = "chatbot-builder-aks"
  description = "Name of the Azure Kubernetes Service (AKS) cluster"
}

variable "production_ip_name" {
  type        = string
  default     = "production-ip"
  description = "Name of the public IP for the production environment"
}

variable "staging_ip_name" {
  type        = string
  default     = "staging-ip"
  description = "Name of the public IP for the staging environment"
}

# So the public IP DNS label will be:
# chatbot-builder-production-dns.israelcentral.cloudapp.azure.com
variable "production_ip_dns_label" {
  type        = string
  description = "DNS label for the production public IP"
  default     = "chatbot-builder-production-dns"
}

# So the public IP DNS label will be:
# chatbot-builder-staging-dns.israelcentral.cloudapp.azure.com
variable "staging_ip_dns_label" {
  type        = string
  description = "DNS label for the staging public IP"
  default     = "chatbot-builder-staging-dns"
}

# AKS cluster configuration
variable "node_count" {
  type        = number
  default     = 1
  description = "Number of nodes in the AKS cluster"
}

variable "vm_size" {
  type        = string
  default     = "Standard_A2_v2"
  description = "VM size for the nodes in the AKS cluster"
}
