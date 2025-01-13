output "production_public_ip" {
  description = "The public IP address for the production environment"
  value       = module.public_ip_production.public_ip_address
}

output "staging_public_ip" {
  description = "The public IP address for the staging environment"
  value       = module.public_ip_staging.public_ip_address
}

output "production_public_ip_fqdn" {
  value = module.public_ip_production.fqdn
}

output "staging_public_ip_fqdn" {
  value = module.public_ip_staging.fqdn
}

output "kube_config" {
  description = "The kubeconfig required to access the AKS cluster"
  value       = module.aks.kube_config
  sensitive   = true
}

output "openai_endpoint" {
  value = module.openai_service.endpoint
}

output "openai_key" {
  value     = module.openai_service.key
  sensitive = true
}