variable "efs_map" {
  type = map(string)
  default = {
    "us-east-1" = 0
    "us-west-2" = 0
    "eu-west-1" = 0
  }
}

variable "customer_name" {
  description = "The customer name that will be used for namespaces"
}

variable "region_id" {
  description = "Only used to check if we are in China or not"
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

variable "efs_throughput_mode" {
  description = "Throughput mode for the file system"
  default     = "bursting"
}

variable "provisioned_throughput_in_mibps" {
  description = "The throughput, measured in MiBps, that you want to provision for the file system."
  default     = null
}
