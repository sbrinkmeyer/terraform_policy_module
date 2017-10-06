//variables.tf

variable "module_tenant_namespace" {
  type        = "string"
  description = "tenant namepsace"
  default     = ""
}

variable "module_account_id" {
  type        = "string"
  description = "the target account id for the tenant"
  default     = ""
}

variable "module_target_region" {
  type        = "string"
  description = "the target region for the tenant"
  default     = ""
}

variable "module_target_moniker" {
  type        = "string"
  description = "the target moniker for the tenant"
  default     = ""
}

variable "module_hosted_zone" {
  type        = "string"
  description = "the target hosted zone for the tenant"
  default     = ""
}

variable "module_target_tstate" {
  type        = "string"
  description = "target terraform state bucket"
  default     = ""
}

variable "module_target_vpc" {
  type        = "string"
  description = "target terraform state bucket"
  default     = ""
}

variable "module_target_efs_fsid" {
  type        = "string"
  description = "the target efs file system id"
  default     = ""
}
