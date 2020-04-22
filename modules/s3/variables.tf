variable "namespace" {
  description = "the tenant namespaces"
}

variable "region" {
  description = "The AWS region to create things in."
}

variable "target_nickname" {
  description = "the cute little nickname for the target account [sbx|non|prd]"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
  type        = map(string)
}

