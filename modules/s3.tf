//s3.tf
data "aws_iam_policy_document" "s3_pd" {
  statement {
    sid    = "AllowUserToSeeBucketListInTheConsole"
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

  statement {
    sid     = "TformRootAndConsumerList"
    effect  = "Allow"
    actions = ["s3:ListBucket"]

    resources = [
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-*",
      "arn:aws:s3:::entsvcs-terraform*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:prefix"
      values   = ["", "${var.module_tenant_namespace}/"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:delimiter"
      values   = ["/"]
    }
  }

  statement {
    sid     = "ListTFormStateFolder"
    effect  = "Allow"
    actions = ["s3:ListBucket"]

    resources = [
      "arn:aws:s3:::entsvcs-terraform*",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values   = ["${var.module_tenant_namespace}/*"]
    }
  }

  statement {
    sid     = "AllowAllS3ActionsInTFormStateFolder"
    effect  = "Allow"
    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-*",
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-*/*",
      "arn:aws:s3:::entsvcs-terraform*/${var.module_tenant_namespace}/*",
    ]
  }

  statement {
    sid    = "DenyAllS3ActionsInTFormStateFolder"
    effect = "Deny"

    actions = [
      "s3:PutBucket*",
      "s3:PutLifecycle*",
      "s3:PutReplication*",
      "s3:PutAcceler*",
      "s3:DeleteBuck*",
    ]

    resources = [
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-*/*",
      "arn:aws:s3:::entsvcs-terraform*/${var.module_tenant_namespace}/*",
    ]
  }

  statement {
    sid    = "AllowCopyAmiCrossAcctCrossRegion"
    effect = "Allow"

    actions = [
      "s3:CreateBucket",
      "s3:GetBucketAcl",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::amis-for-*-in-*",
    ]
  }
}
