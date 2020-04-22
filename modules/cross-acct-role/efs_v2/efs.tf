//efs.tf
//efs extra
// Provides multi-region efs creation
// This file parses the dictionary with the keys being the region and the value being number of drives for that region.

// If more regions become available, the locals section and the modules below will need to be expanded to handle them.
// Make this more readable by separating it out.  Since modules don't support count, we instead pass the region as if we're in China.
locals {
  us_east_1 = substr(var.region_id, 0, 3) == "cn-" ? var.region_id : "us-east-1"
  us_west_2 = substr(var.region_id, 0, 3) == "cn-" ? var.region_id : "us-west-2"
  eu_west_1 = substr(var.region_id, 0, 3) == "cn-" ? var.region_id : "eu-west-1"
}

module "efs_us_east_1" {
  source                          = "./efs_drives/"
  efs_count                       = lookup(var.efs_map, "us-east-1", 0)
  customer_name                   = var.customer_name
  target_nickname                 = var.target_nickname
  target_account_id               = var.target_account_id
  tags                            = var.tags
  region                          = local.us_east_1
  efs_throughput_mode             = var.efs_throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
}

module "efs_us_west_2" {
  source                          = "./efs_drives/"
  efs_count                       = lookup(var.efs_map, "us-west-2", 0)
  customer_name                   = var.customer_name
  target_nickname                 = var.target_nickname
  target_account_id               = var.target_account_id
  tags                            = var.tags
  region                          = local.us_west_2
  efs_throughput_mode             = var.efs_throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
}

module "efs_eu_west_1" {
  source                          = "./efs_drives/"
  efs_count                       = lookup(var.efs_map, "eu-west-1", 0)
  customer_name                   = var.customer_name
  target_nickname                 = var.target_nickname
  target_account_id               = var.target_account_id
  tags                            = var.tags
  region                          = local.eu_west_1
  efs_throughput_mode             = var.efs_throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
}

//Don't bother creating the policies here.  Just hook back into the normal EFS stuff
/*
resource "aws_iam_policy" "efs_policy" {
  name        = "${var.customer_name}-efs2-policy"
  path        = "/"
  description = "${var.customer_name} policy for efs"
  policy      = "${module.managed_policies_module.json_out_map["efs"]}"
  count       = "${var.efs_count == "0" ? 0 : 1}"
}

resource "aws_iam_role_policy_attachment" "efs_policy" {
  count      = "${var.efs_count == "0" ? 0 : 1}"
  role       = "${aws_iam_role.cross_account_role.name}"
  policy_arn = "${aws_iam_policy.efs_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "sso_efs_policy" {
  count      = "${var.clicky_clicky == "yes" && var.efs_count > "0" ? 1 : 0 }"
  role       = "${aws_iam_role.userRole.name}"
  policy_arn = "${aws_iam_policy.efs_policy.arn}"
}
*/
