terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }

  cloud {
    organization = "chatbot-builder"
    workspaces {
      name = "infra-workspace-2"
    }
  }
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

# Define the AKS cluster
module "aks" {
  source              = "./modules/aks"
  cluster_name        = var.cluster_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  node_count          = var.node_count
  vm_size             = var.vm_size
  aks_dns_prefix      = var.cluster_name
}

# Define and output 2 public IPs for the AKS cluster
module "public_ip_production" {
  source              = "./modules/public_ip"
  name                = var.production_ip_name
  location            = module.resource_group.location
  resource_group_name = module.aks.node_resource_group
  domain_name_label   = var.production_ip_dns_label
}

module "public_ip_staging" {
  source              = "./modules/public_ip"
  name                = var.staging_ip_name
  location            = module.resource_group.location
  resource_group_name = module.aks.node_resource_group
  domain_name_label   = var.staging_ip_dns_label
}

# Blob Storage module
module "blob_storage" {
  source                = "./modules/blob_storage"
  name                  = var.storage_account_name
  location              = module.resource_group.location
  resource_group_name   = module.resource_group.resource_group_name
  container_access_type = "blob"
}

# Azure OpenAI service
module "openai_service" {
  source              = "./modules/openai_service"
  name                = var.openai_service_name
  location            = "eastus"
  resource_group_name = module.resource_group.resource_group_name
}