//efs.tf

module "efs_v2" {
  source                          = "./efs_v2/"
  efs_map                         = var.efs_v2
  customer_name                   = var.customer_name
  target_nickname                 = var.target_nickname
  target_account_id               = var.target_account_id
  tags                            = var.tags
  region_id                       = var.region_id
  efs_throughput_mode             = var.efs_throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
}

//easier to do the math in one spot
//Because Terraform is terrible and doesn't easily support simple things like adding a list of numbers
// or letting you pass a list of numbers to max().  Make an external call.
data "external" "total_count" {
  program = concat( list("python"), list("${path.module}/tools/add_list.py"), local.count_list )
}

// use the external program to return how many drives we're creating.  Really all we care about is if the number is 0 or greater than 1
locals {
  count_list = compact(concat([var.efs_count], values(var.efs_v2)))

  //efs_count = "${lookup(data.external.total_count.result, "Result", 0)}"
  efs_count = data.external.total_count.result["Result"]
}

resource "aws_efs_file_system" "policy_created_efs" {
  tags = merge(
    var.tags,
    {
      "Name" = format(
        "%s-%s-%s-%02d",
        lower(var.customer_name),
        lower(var.target_nickname),
        var.region_id,
        count.index + 1,
      )
    },
  )
  count = var.efs_count
}

resource "aws_iam_policy" "efs_policy" {
  name        = "${var.customer_name}-efs-policy"
  path        = "/"
  description = "${var.customer_name} policy for efs"
  policy      = module.managed_policies_module.json_out_map["efs"]
  count       = local.efs_count == "0" ? 0 : 1
}

resource "aws_iam_role_policy_attachment" "efs_policy" {
  count      = local.efs_count == "0" ? 0 : 1
  role       = aws_iam_role.cross_account_role.name
  policy_arn = aws_iam_policy.efs_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "sso_efs_policy" {
  count      = var.clicky_clicky == "yes" && local.efs_count > "0" ? 1 : 0
  role       = aws_iam_role.userRole.name
  policy_arn = aws_iam_policy.efs_policy[0].arn
}

