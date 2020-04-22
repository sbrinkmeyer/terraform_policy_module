//variables.tf

variable "module_customer_namespace" {
  type        = string
  description = "Customer namepsace"
  default     = ""
}

variable "module_account_id" {
  type        = string
  description = "the target account id for the customer"
  default     = ""
}

variable "module_target_region" {
  type        = string
  description = "the target region for the customer"
  default     = ""
}

variable "module_target_moniker" {
  type        = string
  description = "the target moniker for the customer"
  default     = ""
}

variable "module_prefix_option" {
  type        = string
  description = "Prefix option for the tenant - ussually empty"
  default     = ""
}

variable "module_hosted_zone" {
  type        = string
  description = "the target hosted zone for the customer (the zone id)"
  default     = ""
}

variable "module_target_vpc" {
  type        = string
  description = "target terraform state bucket"
  default     = ""
}

variable "efs_arns" {
  type        = list(string)
  description = "efs arns"
  default     = []
}

variable "sns_arns" {
  type        = list(string)
  description = "sns cross account arns generated from a list"
  default     = []
}

variable "partition" {
  description = "AWS arn partition. defaults to aws; use aws-cn in China"
  default     = "aws"
}

variable "neptune_arns" {
  description = "List of AWS Neptune cluster ARNs for the namespace"
  type        = list(string)
  default     = []
}

