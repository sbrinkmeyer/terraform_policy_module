variable "prefix_option" {
  default = ""
}

variable "customer_name" {
  description = "The customer name that will be used for namespaces"
}

variable "region_id" {
  description = "The AWS region to create things in."
}

variable "target_account_tldn" {
  description = "this is the tldn for the account (defaults to thecommons.business.com) "
  default     = "thecommons.business.com"
}

variable "target_account_id" {
  description = "the aws account id for where these options are being targeted"
}

variable "target_nickname" {
  description = "the cute little nickname for the target account [sbx|non|prd]"
}

// this isn't used yet, so I'm allowing an empty string
variable "target_vpc" {
  description = "the target vpc that the policies will be namespaced for"
  default     = ""
}

variable "created_policies" {
  description = "array of policies that will be created, namespaced and deployed, but not attached by default"
  default     = []
}

variable "managed_policies" {
  description = "array of policies that will be namespaced and deployed"
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
  type        = map(string)
}

// defaulted for module
variable "saml_provider" {
  description = "the name of the saml provider for the account [business-okta|business-sso]"
  default     = "business-sso"
}

variable "entsvcs_account_id" {
  description = "The AWS Account where the build agent resides"
  default     = "944807178991"
}

variable "BAR_case" {
  description = "allows the agent to have upper/lower case to hook to inverse buildagentrolename"
  default     = "false"
}

variable "always_policies" {
  description = "these policies are in the base policy and don't need to be attached"

  // do not include ec2, iam, s3, autoscaling, elb, or dynamodb in the list as these are part of base
  default = ["ec2", "iam", "s3", "dynamodb", "cloudwatchlogs", "cloudformation"]
}

// see carrierint for an example - their s3 resources are managed directly
// so the tenant can provide custom lifecycle rules
variable "s3_refactor" {
  description = "manage tenant's s3 bucket seperately"
  default     = "0"
}

variable "clicky_clicky" {
  description = "allows the console user to have agent access"
  default     = "no"
}

variable "read_only_arns" {
  description = "read-only arns for (non clicky-clicky) console access"

  /* override for china */
  default = [
    "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess",
    "arn:aws:iam::aws:policy/IAMReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSSupportAccess",
  ]
}

variable "support_role" {
  description = <<EOF
Create a tenantSupport role for console access
Contains some basic stop/start commands for ec2 and rds
EOF


  default = "0"
}

variable "route53_enabled" {
  description = <<EOF
Whether or not to create a route53 zone for the tenant.
Defaults to 1 (true)
Set to 0 for tenants in AWS China
EOF


default = "1"
}

variable "partition" {
description = "AWS arn partition"
default     = "aws"
}

variable "aws_resource_identifier" {
description = "resource identifiers for IAM"
default     = "amazonaws.com"
}

variable "efs_count" {
description = "number of efs instances to create"
default     = "0"
}

//eventually efs_v2 should replace efs_count.
variable "efs_v2" {
description = "Take a map with keys being aws regions and the values being how many efs drives to create in each region"
type        = map(string)
default = {
"us-east-1" = 0
"us-west-2" = 0
"eu-west-1" = 0
}
}

variable "efs_throughput_mode" {
  description = "Throughput mode for the file system"
  default     = "bursting"
}

variable "provisioned_throughput_in_mibps" {
  description = "The throughput, measured in MiBps, that you want to provision for the file system."
  default     = null
}

variable "sns_xaccount_list" {
description = "list of accounts that will allow sns subscriptions.  be safe and have different lists per env"
default     = []
type        = list(string)
}

variable "bmx_nodes" {
description = "Name of your BMX instances, this provided in a list because some have multiple BMX instances."
default     = []
type        = list(string)
}

variable "bmx_account_id" {
description = "AWS Account ID of the account where BMX is running"
default     = "046979685931"
}

variable "neptune_arns" {
description = "List of AWS Neptune cluster ARNs for the namespace"
type        = list(string)
default     = []
}

variable "data_role_enabled" {
  description = "allows console access to data services like s3, athena and glue"
  default     = "no"
}
