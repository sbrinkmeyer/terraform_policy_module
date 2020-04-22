//sso_role.tf

data "aws_iam_policy_document" "assumesamlpolicydoc" {
  statement {
    effect = "Allow"

    principals {
      type = "Federated"

      identifiers = [
        "arn:${var.partition}:iam::${var.target_account_id}:saml-provider/nike-okta",
        "arn:${var.partition}:iam::${var.target_account_id}:saml-provider/${var.saml_provider}",
      ]
    }

    actions = ["sts:AssumeRoleWithSAML"]

    condition {
      test     = "StringEquals"
      variable = "SAML:aud"

      values = [
        "https://signin.aws.amazon.com/saml",
        "https://signin.amazonaws.cn/saml",
      ]
    }
  }
}

resource "aws_iam_role" "userRole" {
  name               = var.customer_name
  assume_role_policy = data.aws_iam_policy_document.assumesamlpolicydoc.json
  tags = merge(
    var.tags,
    {
      "Name" = format("%s-%s", lower(var.customer_name), "ssoRole")
    },
  )
}

// CLICKY-CLICKY
// attaches the inline policy that has ec2, iam, and a few others
resource "aws_iam_role_policy" "sso_policy_base_inline" {
  count  = var.clicky_clicky == "yes" ? 1 : 0
  name   = "sso-base-inline-policy"
  role   = aws_iam_role.userRole.id
  policy = module.managed_policies_module.json_out_map["base"]
}

// this attaches everything in the managed_policies array.  not right, un-
//  necessary attachments as this includes ec2, iam and others duplicated in
//  base.
resource "aws_iam_role_policy_attachment" "sso_policy_attach_all" {
  count      = var.clicky_clicky == "yes" ? length(var.managed_policies) : 0
  role       = aws_iam_role.userRole.name
  policy_arn = element(aws_iam_policy.poc_policies.*.arn, count.index)
}

// NO CLICKY-CLICKY
// if "clicky-clicky" is false, attach some read-only policies
// as well as the ro_base inline policy which fills a few gaps
resource "aws_iam_role_policy_attachment" "sso_policy_attach_readonly" {
  count      = var.clicky_clicky == "yes" ? 0 : length(var.read_only_arns)
  role       = aws_iam_role.userRole.name
  policy_arn = element(var.read_only_arns, count.index)
}

//Get around needing nested quotes by pregenerating the needed element
// Locals are actually at the module level, but it's nice to be able to see what it happening in the same file.

// CAT-1137 blugh
/*
locals {
  sso_cloudformation_policy    = "${var.customer_name}-cloudformation-policy"
  sso_cloudformation_policy_id = "${index(aws_iam_policy.always_policies.*.name, local.sso_cloudformation_policy)}"
}

// Explicitly attach cloudformation from the always policies to the role
resource "aws_iam_role_policy_attachment" "sso_cloudformation_policy_attach" {
  count      = "${var.clicky_clicky == "yes" ? 1 : 0 }"
  role       = "${aws_iam_role.userRole.name}"
  policy_arn = "${element(aws_iam_policy.always_policies.*.arn, local.sso_cloudformation_policy_id)}"
  depends_on  = ["aws_iam_policy.always_policies"]
}
*/

locals {
  dynamodb_policy_sso = "${var.customer_name}-dynamodb-policy"
  dynamodb_policy_sso_id = index(
    aws_iam_policy.always_policies.*.name,
    local.dynamodb_policy_sso,
  )
}

// Explicitly attach dynamodb from the always policies to the role
resource "aws_iam_role_policy_attachment" "sso_dynamodb_policy_attach" {
  count = var.clicky_clicky == "yes" ? 1 : 0
  role  = aws_iam_role.userRole.name
  policy_arn = element(
    aws_iam_policy.always_policies.*.arn,
    local.dynamodb_policy_sso_id,
  )
  depends_on = [aws_iam_policy.always_policies]
}

// to include the separated out tenant-ec2 policy
locals {
  ec2_policy_sso    = "${var.customer_name}-ec2-policy"
  ec2_policy_sso_id = index(aws_iam_policy.always_policies.*.name, local.ec2_policy_sso)
}

// Explicitly attach ec2 from the always policies to the role
resource "aws_iam_role_policy_attachment" "sso_ec2_policy_attach" {
  count = var.clicky_clicky == "yes" ? 1 : 0
  role  = aws_iam_role.userRole.name
  policy_arn = element(
    aws_iam_policy.always_policies.*.arn,
    local.ec2_policy_sso_id,
  )
  depends_on = [aws_iam_policy.always_policies]
}

resource "aws_iam_role_policy" "ro_base_inline_policy" {
  count  = var.clicky_clicky == "yes" ? 0 : 1
  name   = "base-inline-ro-policy"
  role   = aws_iam_role.userRole.id
  policy = module.managed_policies_module.json_out_map["ro-base"]
}

// tenantSupport role
resource "aws_iam_role" "support" {
  count              = var.clicky_clicky == "yes" ? 0 : 1
  name               = "${var.customer_name}Support"
  assume_role_policy = data.aws_iam_policy_document.assumesamlpolicydoc.json
  tags = merge(
    var.tags,
    {
      "Name" = format("%s-%s", lower(var.customer_name), "supportRole")
    },
  )
}

// attach the read-only inline policy to the tenantSupport role
resource "aws_iam_role_policy" "support-ro" {
  count  = var.clicky_clicky == "yes" ? 0 : 1
  name   = "sso-support-base-inline-policy"
  role   = aws_iam_role.support[0].id
  policy = module.managed_policies_module.json_out_map["ro-base"]
}

// attach the support inline policy to the tenantSupport role
resource "aws_iam_role_policy" "support" {
  count  = var.clicky_clicky == "yes" ? 0 : 1
  name   = "sso-support-policy"
  role   = aws_iam_role.support[0].id
  policy = module.managed_policies_module.json_out_map["support-base"]
}

// attach the additional read-only arns to the tenantSupport role
resource "aws_iam_role_policy_attachment" "support" {
  count      = var.clicky_clicky == "yes" ? 0 : length(var.read_only_arns)
  role       = aws_iam_role.support[0].name
  policy_arn = element(var.read_only_arns, count.index)
}


//tenantData role
resource "aws_iam_role" "data_role" {
  count              = var.data_role_enabled == "yes" ? 1 : 0
  name               = "${var.customer_name}Data"
  assume_role_policy = data.aws_iam_policy_document.assumesamlpolicydoc.json
  tags = merge(
    var.tags,
    {
      "Name" = format("%s-%s", lower(var.customer_name), "dataRole")
    },
  )
}

// attach the base inline policy for read only roles
resource "aws_iam_role_policy" "data_role_inline_policy" {
  count  = var.data_role_enabled == "yes" ? 1 : 0
  name   = "base-inline-ro-policy-data"
  role   = aws_iam_role.data_role[0].id
  policy = module.managed_policies_module.json_out_map["ro-base"]
}

// attach the additional read-only policies to the tenantData role
resource "aws_iam_role_policy_attachment" "data_role_read_only_policies" {
  count      = var.data_role_enabled == "yes" ? length(var.read_only_arns) : 0
  role       = aws_iam_role.data_role[0].name
  policy_arn = element(var.read_only_arns, count.index)
}

//attachment of the addtional write policies to the tenantData role
resource "aws_iam_role_policy" "data_role_inline_policy_s3_ro" {
  count  = var.data_role_enabled == "yes" ? 1 : 0
  name   = "inline-s3-ro-policy-data"
  role   = aws_iam_role.data_role[0].id
  policy = module.managed_policies_module.json_out_map["s3_ro"]
}

resource "aws_iam_role_policy" "data_role_inline_policy_glue" {
  count  = var.data_role_enabled == "yes" ? 1 : 0
  name   = "inline-glue-policy-data"
  role   = aws_iam_role.data_role[0].id
  policy = module.managed_policies_module.json_out_map["glue"]
}
