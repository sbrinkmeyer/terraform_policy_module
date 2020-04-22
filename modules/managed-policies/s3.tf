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
      "arn:${var.partition}:s3:::*",
    ]
  }

  statement {
    sid       = "TformRootAndConsumerList"
    effect    = "Allow"
    actions   = ["s3:List*"]
    resources = ["arn:${var.partition}:s3:::entsvcs-terraform*"]
  }

  statement {
    sid     = "AllowAllS3ActionsInTFormStateFolder"
    effect  = "Allow"
    actions = ["s3:*"]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*/*",
      "arn:${var.partition}:s3:::entsvcs-terraform*/${var.module_customer_namespace}/*",
    ]
  }

  statement {
    sid    = "AllowS3BucketNotifications"
    effect = "Allow"

    actions = [
      "s3:PutBucketNotification",
      "s3:GetBucketNotification",
    ]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*/*",
    ]
  }

  // This block overrides the s3:* above
  statement {
    effect = "Deny"

    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
    ]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-${lower(var.module_prefix_option)}${lower(var.module_target_moniker)}-*",
      "arn:${var.partition}:s3:::entsvcs-terraform*/${var.module_customer_namespace}",
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
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-${lower(var.module_prefix_option)}${lower(var.module_target_moniker)}-*/*",
      "arn:${var.partition}:s3:::entsvcs-terraform*/${var.module_customer_namespace}/*",
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
      "arn:${var.partition}:s3:::amis-for-*-in-*",
    ]
  }

  // AAA JWT Key Management SVCS
  // https://confluence.nike.com/display/SECDEV/Nike+JWT+Reference+Guide

  // Allows tenants to list objects in public-keys and their private-keys subdirectory
  statement {
    sid       = "AccessToAAAKeyBucketSubfolders"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:${var.partition}:s3:::internal.thecommons*"]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "",
        "private-keys/",
        "private-keys/${var.module_customer_namespace}/*",
        "public-keys/*",
      ]
    }
  }

  // Allow tenants to get objects in public-keys and their subdirectory
  statement {
    sid     = "AccessToAAAKeyObjects"
    effect  = "Allow"
    actions = ["s3:GetObject"]

    resources = [
      "arn:${var.partition}:s3:::internal.thecommons*/private-keys/${var.module_customer_namespace}/*",
      "arn:${var.partition}:s3:::internal.thecommons*/public-keys/*",
    ]
  }
}

