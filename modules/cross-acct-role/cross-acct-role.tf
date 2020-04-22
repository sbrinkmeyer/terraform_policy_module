/******
Creates an IAM cross account role in the target environment
******/

locals {
  fixed_identifiers = [
    "arn:${var.partition}:iam::${var.entsvcs_account_id}:role/ciProvisioner",
    "arn:${var.partition}:iam::${var.entsvcs_account_id}:role/${var.BAR_case == "false" ? var.customer_name : var.BAR_case}BuildAgentRole",
    "arn:${var.partition}:iam::${var.target_account_id}:user/s.${var.customer_name}-builduser",
  ]

/* no bmx in china */
  bmx_identifiers = formatlist(
    "arn:aws:iam::${var.bmx_account_id}:role/brewmaster/base/brewmaster-base-%s",
    var.bmx_nodes,
  )
}

locals {
  cross_acct_identifiers = concat(local.fixed_identifiers, local.bmx_identifiers)
}

data "aws_iam_policy_document" "crossaccountpolicydocument" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.${var.aws_resource_identifier}"]
    }

    principals {
      type = "AWS"

      # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
      # force an interpolation expression to be interpreted as a list by wrapping it
      # in an extra set of list brackets. That form was supported for compatibilty in
      # v0.11, but is no longer supported in Terraform v0.12.
      #
      # If the expression in the following list itself returns a list, remove the
      # brackets to avoid interpretation as a list of lists. If the expression
      # returns a single list item then leave it as-is and remove this TODO comment.
      identifiers = local.cross_acct_identifiers
    }

    actions = ["sts:AssumeRole"]
  }
}

# Specify the provider and access details
provider "aws" {
  region = var.region_id
}

resource "aws_iam_role" "cross_account_role" {
  name               = "${var.customer_name}BuildAgentRole"
  assume_role_policy = data.aws_iam_policy_document.crossaccountpolicydocument.json
  depends_on         = [aws_iam_user.build_user]

  tags = merge(
    var.tags,
    {
      "Name" = format("%s-%s", lower(var.customer_name), "BuildAgentRole")
    },
  )
}

// attaches the inline policy that has ec2, iam, and a few others
resource "aws_iam_role_policy" "base_inline_policy" {
  name   = "base-inline-policy"
  role   = aws_iam_role.cross_account_role.id
  policy = module.managed_policies_module.json_out_map["base"]
}

// this attaches everything in the managed_policies array.
resource "aws_iam_role_policy_attachment" "cross_account_policy_attach" {
  count      = length(var.managed_policies)
  role       = aws_iam_role.cross_account_role.name
  policy_arn = element(aws_iam_policy.poc_policies.*.arn, count.index)
}

//Get around needing nested quotes by pregenerating the needed element
// Locals are actually at the module level, but it's nice to be able to see what it happening in the same file.

// Customer hit max policies do to a change in us breaking out s3 from base-inline-policy [CAT-1137]
/*
locals {
  cloudformation_policy    = "${var.customer_name}-cloudformation-policy"
  cloudformation_policy_id = "${index(aws_iam_policy.always_policies.*.name, local.cloudformation_policy)}"
}

// Explicitly attach cloudformation from the always policies to the role
resource "aws_iam_role_policy_attachment" "cross_account_cloudformation_policy_attach" {
  role       = "${aws_iam_role.cross_account_role.name}"
  policy_arn = "${element(aws_iam_policy.always_policies.*.arn, local.cloudformation_policy_id)}"
  depends_on = ["aws_iam_policy.always_policies"]
}
*/

locals {
  dynamodb_policy    = "${var.customer_name}-dynamodb-policy"
  dynamodb_policy_id = index(aws_iam_policy.always_policies.*.name, local.dynamodb_policy)
}

// Explicitly attach dynamodb from the always policies to the role
resource "aws_iam_role_policy_attachment" "cross_account_dynamodb_policy_attach" {
  role = aws_iam_role.cross_account_role.name
  policy_arn = element(
    aws_iam_policy.always_policies.*.arn,
    local.dynamodb_policy_id,
  )
  depends_on = [aws_iam_policy.always_policies]
}

locals {
  ec2_policy    = "${var.customer_name}-ec2-policy"
  ec2_policy_id = index(aws_iam_policy.always_policies.*.name, local.ec2_policy)
}

// Explicitly attach ec2 from the always policies to the role
resource "aws_iam_role_policy_attachment" "cross_account_ec2_policy_attach" {
  role       = aws_iam_role.cross_account_role.name
  policy_arn = element(aws_iam_policy.always_policies.*.arn, local.ec2_policy_id)
  depends_on = [aws_iam_policy.always_policies]
}

locals {
  s3_policy    = "${var.customer_name}-s3-policy"
  s3_policy_id = index(aws_iam_policy.always_policies.*.name, local.s3_policy)
}

// Explicitly attach s3 from the always policies to the role
resource "aws_iam_role_policy_attachment" "cross_account_s3_policy_attach" {
  role       = aws_iam_role.cross_account_role.name
  policy_arn = element(aws_iam_policy.always_policies.*.arn, local.s3_policy_id)
  depends_on = [aws_iam_policy.always_policies]
}

