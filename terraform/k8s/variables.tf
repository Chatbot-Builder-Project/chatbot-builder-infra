variable "staging_namespace_name" {
  description = "Kubernetes namespace name for staging"
  default     = "staging"
  type        = string
}

variable "production_namespace_name" {
  description = "Kubernetes namespace name for production"
  default     = "production"
  type        = string
}