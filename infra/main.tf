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
      name = "infra-workspace"
    }
  }
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

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
  resource_group_name = module.resource_group.resource_group_name
}

module "public_ip_staging" {
  source              = "./modules/public_ip"
  name                = var.staging_ip_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
}
