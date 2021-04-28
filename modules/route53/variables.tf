variable "customer_name" {
  description = "The customer name that will be used for namespaces"
}

variable "target_nickname" {
  description = "the cute little nickname for the target account [sbx|non|prd]"
}

variable "target_account_tldn" {
  description = "this is the tldn for the account (defaults to thecommons.business.com) "
  default     = "thecommons.business.com"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
  type        = map(string)
}

