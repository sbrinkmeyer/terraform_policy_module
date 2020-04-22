//kinesisvideo.tf
data "aws_iam_policy_document" "kinesisvideo_pd" {
  statement {
    sid    = "AllowKinesisVideoStreamsManagementBySplat"
    effect = "Allow"

    actions = [
      "kinesisvideo:CreateStream",
      "kinesisvideo:DescribeStream",
      "kinesisvideo:ListStreams",
    ]

    resources = ["*"]
  }

  statement {
    sid       = "AllowKinesisVideoStreamsManagementByNamespace"
    effect    = "Allow"
    actions   = ["kinesisvideo:*"]
    resources = ["arn:${var.partition}:kinesisvideo:*:*:stream/${var.module_customer_namespace}-*"]
  }
}

