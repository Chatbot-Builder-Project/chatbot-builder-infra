terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
  }

  cloud {
    organization = "chatbot-builder"
    workspaces {
      name = "k8s-workspace"
    }
  }
}

module "namespace_production" {
  source = "./modules/namespace"
  name   = var.production_namespace_name
}

module "namespace_staging" {
  source = "./modules/namespace"
  name   = var.staging_namespace_name
}
