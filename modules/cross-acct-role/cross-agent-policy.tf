/******
Creates the IAM Policy or Policies
******/

// Grab the list of arns we normally would create, and add the efs_v2 arns to the list.
locals {
  efs_count_arns = formatlist(
    "arn:%s:elasticfilesystem:*:%s:file-system/%s",
    var.partition,
    var.target_account_id,
    aws_efs_file_system.policy_created_efs.*.id,
  )
  efs_arns = compact(concat(local.efs_count_arns, module.efs_v2.efs_arns))
}

//this module generates the json for all known policies with namespaces
module "managed_policies_module" {
  source                    = "../managed-policies"
  module_customer_namespace = var.customer_name
  module_account_id         = var.target_account_id
  module_target_region      = var.region_id
  module_target_moniker     = var.target_nickname
  module_target_vpc         = var.target_vpc
  module_prefix_option      = var.prefix_option
  partition                 = var.partition

  # When route53 is disabled, the template route53_zone
  # resource gets a count of zero which triggers an evaluation error.
  module_hosted_zone = join("", aws_route53_zone.env_name.*.zone_id)

  //efs_arns = "${formatlist("arn:%s:elasticfilesystem:*:%s:file-system/%s", var.partition, var.target_account_id, aws_efs_file_system.policy_created_efs.*.id)}"
  efs_arns = local.efs_arns

  # this is to support cross account sns topic subscriptions.  we could be
  #  and have the tenant give us a map of topic-name : account then create
  #  explicit arns. stealing from above cause in a pinch
  sns_arns = formatlist("arn:%s:sns:*:%s:*", var.partition, var.sns_xaccount_list)

  # Neptune clusters can't be namespaced so we need to give access to explicit clusters.
  # ARN format is 'arn:aws:neptune-db:region:account-id:cluster-resource-id/*'
  neptune_arns = var.neptune_arns
}

// we then use the output of the module's map to create the policies we want
// This is for creating policies but not automatically attaching them.
resource "aws_iam_policy" "created_policies" {
  name        = "${var.customer_name}-${element(var.created_policies, count.index)}-policy"
  path        = "/"
  description = "${var.customer_name} policy for ${element(var.created_policies, count.index)}"
  policy      = module.managed_policies_module.json_out_map[element(var.created_policies, count.index)]
  count       = length(var.created_policies)
}

// we then use the output of the module's map to create the policies we want
resource "aws_iam_policy" "poc_policies" {
  name        = "${var.customer_name}-${element(var.managed_policies, count.index)}-policy"
  path        = "/"
  description = "${var.customer_name} policy for ${element(var.managed_policies, count.index)}"
  policy      = module.managed_policies_module.json_out_map[element(var.managed_policies, count.index)]
  count       = length(var.managed_policies)
}

// we then use the output of the module's map to create the ALWAYS policies we want that are part of the base inline policy
resource "aws_iam_policy" "always_policies" {
  name        = "${var.customer_name}-${element(var.always_policies, count.index)}-policy"
  path        = "/"
  description = "${var.customer_name} policy for ${element(var.always_policies, count.index)}"
  policy      = module.managed_policies_module.json_out_map[element(var.always_policies, count.index)]
  count       = length(var.always_policies)
  depends_on  = [aws_iam_policy.poc_policies]
}

