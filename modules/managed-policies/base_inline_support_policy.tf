// base inline policy for ReadOnly SSO Roles
// The permissions in this policy are meant to expand the existing AWS ViewOnly Console role
// adding appropriate, namespaced "describe" policies to namespaced resources

data "aws_iam_policy_document" "support_base_pd" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:CreateBackup",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:ListBackups",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:RestoreTableFromBackup",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
    ]

    resources = [
      "arn:${var.partition}:dynamodb:*:*:table/${lower(var.module_customer_namespace)}-*",
    ]
  }

  statement {
    actions = [
      "rds:Download*",
      "rds:StartDBInstance",
      "rds:StopDBInstance",
      "rds:RebootDBInstance",
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "rds:db-tag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:RebootInstances",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
    ]

    resources = [
      "arn:${var.partition}:ec2:*:${var.module_account_id}:instance/*",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:InstanceProfile"
      values   = ["arn:${var.partition}:iam::${var.module_account_id}:instance-profile/${var.module_customer_namespace}*"]
    }
  }

  // cloudwatch events API
  statement {
    effect    = "Allow"
    actions   = ["logs:FilterLogEvents"]
    resources = ["*"]
  }

  statement {
    actions   = ["tag:getResources"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:${var.partition}:s3:::*",
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:List*"]
    resources = ["arn:${var.partition}:s3:::entsvcs-terraform*"]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:*"]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*/*",
      "arn:${var.partition}:s3:::entsvcs-terraform*/${var.module_customer_namespace}/*",
    ]
  }

  statement {
    effect = "Deny"

    actions = [
      "s3:PutBucket*",
      "s3:PutLifecycle*",
      "s3:PutReplication*",
      "s3:PutAcceler*",
      "s3:DeleteBuck*",
    ]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*/*",
      "arn:${var.partition}:s3:::entsvcs-terraform*/${var.module_customer_namespace}/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ses:Get*",
      "ses:Describe*",
    ]

    resources = ["*"]
  }

  // health dashboard (for console users)
  statement {
    effect    = "Allow"
    actions   = ["health:Describe*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "sts:DecodeAuthorizationMessage",
    ]
    resources = ["*"]
  }

  statement {
    actions   = ["glue:*"]
    resources = ["*"]
  }

  statement {
    actions   = ["athena:*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "pi:Describe*",
      "pi:Get*",
    ]

    resources = [
      "arn:${var.partition}:pi:*:*:metrics/*/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "xray:Get*",
    ]

    resources = ["*"]
  }

  statement {
    sid       = "SecretsManagerListSecrets"
    effect    = "Allow"
    actions   = ["secretsmanager:ListSecrets"]
    resources = ["*"]
  }

  statement {
    sid       = "SecretsManagerRandomPassword"
    effect    = "Allow"
    actions   = ["secretsmanager:GetRandomPassword"]
    resources = ["*"]
  }

  statement {
    sid    = "SecretsManagerRemaining"
    effect = "Allow"
    actions = [
      "secretsmanager:CancelRotateSecret",
      "secretsmanager:DeleteSecret",
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:ListSecretVersionIds",
      "secretsmanager:PutSecretValue",
      "secretsmanager:RestoreSecret",
      "secretsmanager:RotateSecret",
      "secretsmanager:TagResource",
      "secretsmanager:UntagResource",
      "secretsmanager:UpdateSecret",
      "secretsmanager:UpdateSecretVersionStage",
    ]
    resources = [
      "arn:${var.partition}:secretsmanager:*:${var.module_account_id}:secret:${var.module_customer_namespace}-*",
      "arn:${var.partition}:secretsmanager:*:${var.module_account_id}:secret:${var.module_customer_namespace}/*",
    ]
  }
}

