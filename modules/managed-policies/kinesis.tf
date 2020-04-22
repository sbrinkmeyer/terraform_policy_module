//kinesis.tf
data "aws_iam_policy_document" "kinesis_pd" {
  statement {
    sid       = "AllowKinesisManagementByNamespace"
    effect    = "Allow"
    actions   = ["kinesis:*"]
    resources = ["arn:${var.partition}:kinesis:*:*:stream/${var.module_customer_namespace}*"]
  }

  statement {
    sid    = "AllowKinesisManagementByStar"
    effect = "Allow"

    actions = [
      "kinesis:DescribeLimits",
      "kinesis:DisableEnhancedMonitoring",
      "kinesis:EnableEnhancedMonitoring",
      "kinesis:ListShards",
      "kinesis:ListStreams",
      "kinesis:UpdateShardCount",
    ]

    resources = ["*"]
  }
}

