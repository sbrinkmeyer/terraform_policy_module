// base inline policy for ReadOnly SSO Roles
// The permissions in this policy are meant to expand the existing AWS ViewOnly Console role
// adding appropriate, namespaced "describe" policies to namespaced resources

data "aws_iam_policy_document" "ro_base_pd" {
  statement {
    actions = [
      "acm:List*",
      "acm:DescribeCertificate",
    ]

    resources = ["*"]
  }

  statement {
    actions   = ["apigateway:GET"]
    resources = ["*"]
  }

  statement {
    actions = ["cloudformation:Describe*"]

    resources = [
      "arn:aws:cloudformation:*:${var.module_account_id}:stack/${lower(var.module_tenant_namespace)}*",
    ]
  }

  statement {
    actions   = ["dynamodb:Describe*"]
    resources = ["arn:aws:dynamodb:*:*:table/${lower(var.module_tenant_namespace)}-*"]
  }

  statement {
    actions   = ["ec2:DescribeTags"]
    resources = ["*"]
  }

  statement {
    actions   = ["ecs:Describe*"]
    resources = ["*"]
  }

  statement {
    actions = ["ecr:Describe*"]

    resources = [
      "arn:aws:ecr:*:${var.module_account_id}:repository/${lower(var.module_tenant_namespace)}*",
    ]
  }

  statement {
    actions   = ["efs:Describe*"]
    resources = ["*"]
  }

  statement {
    actions   = ["elasticache:Describe*"]
    resources = ["*"]
  }

  statement {
    actions   = ["elasticbeanstalk:Describe*"]
    resources = ["*"]
  }

  statement {
    actions  = ["elasticloadbalancing:Describe*"]
    resources = ["*"]
  }

  statement {
    actions   = ["kinesis:Describe*"]
    resources = ["arn:aws:kinesis:*:*:stream/${lower(var.module_tenant_namespace)}*"]
  }

  statement {
    actions = [
      "kms:ListAliases",
      "kms:DescribeKey",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "lambda:GetAccountSettings",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "lambda:Describe*",
      "lambda:Get*",
    ]

    resources = ["arn:aws:lambda:*:*:function:${lower(var.module_tenant_namespace)}-*"]
  }

  statement {
    actions   = ["rds:Describe*"]
    resources = ["*"]
  }

  statement {
    actions = [
      "s3:ListBucket",
      "s3:Get*",
    ]

    resources = [
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-${lower(var.module_target_moniker)}-${var.module_target_region}",
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-${lower(var.module_target_moniker)}-${var.module_target_region}/*",
    ]
  }
}
