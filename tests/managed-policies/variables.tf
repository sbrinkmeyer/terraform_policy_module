//variables.tf

variable "managed_policies" {
    type        =   "list"
    description =   "List of managed policies required"
    default     =   []
}

variable "tenant_namespace" {
    type        =   "string"
    description =   "tenant namepsace"
    default     =   ""
}

variable "account_id" {
    type        =   "string"
    description =   "the target account id for the tenant"
    default     =   ""
}

variable "target_region" {
    type        =   "string"
    description =   "the target region for the tenant"
    default     =   ""
}

variable "hosted_zone" {
    type        =   "string"
    description =   "the hosted zone for the tenant if required"
    default     =   "0123456789ABCD"
}
variable "target_moniker" {
    type        =   "string"
    description =   "the nickname/moniker for the target account [sbx|non|prd"
    default     =   ""
}
variable "target_tstate" {
    type        =   "string"
    description =   "the target terraform state bucket that the tenant can use"
    default     =   ""
}
variable "target_vpc" {
    type        =   "string"
    description =   "the target vpc for the tenant"
    default     =   ""
}
variable "target_efs_fsid" {
    type        =   "string"
    description =   "target ef file system id if requested"
    default     =   "fs-01234567"
}
