//s3_ro.tf
data "aws_iam_policy_document" "s3_ro_pd" {
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
    sid    = "AllowAllS3ActionsInTFormStateFolder"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*",
    ]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*/*",
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
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*/*",
    ]
  }
}

