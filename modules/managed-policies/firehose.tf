//firehose.tf
data "aws_iam_policy_document" "firehose_pd" {
  statement {
    sid    = "AllowFirehoseManagementByStar"
    effect = "Allow"

    actions = [
      "firehose:CreateDeliveryStream",
      "firehose:DescribeDeliveryStream",
      "firehose:ListDeliveryStreams",
      "firehose:ListTagsForDeliveryStream",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowFirehoseManagementByTeamNamespace"
    effect = "Allow"

    actions = [
      "firehose:Delete*",
      "firehose:Put*",
      "firehose:Update*",
      "firehose:TagDeliveryStream",
      "firehose:UntagDeliveryStream",
    ]

    resources = ["arn:${var.partition}:firehose:*:*:deliverystream/${var.module_customer_namespace}-*"]
  }
}

