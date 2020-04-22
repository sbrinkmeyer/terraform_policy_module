//secretsmanager.tf
// Secrets Manager Policy
// Docs: https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html
data "aws_iam_policy_document" "secretsmanager_pd" {
  statement {
    sid       = "SecretsManagerListSecrets"
    effect    = "Allow"
    actions   = ["secretsmanager:ListSecrets"]
    resources = ["*"]
  }

  statement {
    sid       = "SecretsManagerCreate"
    effect    = "Allow"
    actions   = ["secretsmanager:CreateSecret"]
    resources = ["*"]
    condition {
      test     = "ForAnyValue:StringLike"
      variable = "secretsmanager:Name"
      values = [
        "${var.module_customer_namespace}-*",
        "${var.module_customer_namespace}/*",
      ]
    }
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

