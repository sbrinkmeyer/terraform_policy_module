variable "region" {
  description = "The AWS region to be using"
}

variable "customer_name" {
  description = "The customer name that will be used for namespaces"
}

variable "efs_count" {
  description = "The number of EFS drives to put in the region"
}

variable "efs_throughput_mode" {
  description = "Throughput mode for the file system"
  default     = "bursting"
}

variable "provisioned_throughput_in_mibps" {
  description = "The throughput, measured in MiBps, that you want to provision for the file system."
  default     = null
}

variable "target_nickname" {
  description = "the cute little nickname for the target account [sbx|non|prd]"
}

variable "target_account_id" {
  description = "The target account id"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
  type        = map(string)
}

variable "partition" {
  description = "The AWS partition to be using"
  default     = "aws"
}

