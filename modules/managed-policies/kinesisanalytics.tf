//KinesisAnalytics.tf
data "aws_iam_policy_document" "kinesisanalytics_pd" {
  statement {
    sid    = "AllowKinesisAnalyticsManagementByStar"
    effect = "Allow"

    actions = [
      "kinesisanalytics:CreateApplication",
      "kinesisanalytics:ListApplications",
      "kinesisanalytics:DiscoverInputSchema",
    ]

    resources = ["*"]
  }

  statement {
    sid       = "AllowKinesisAnalyticsManagementByNamespace"
    effect    = "Allow"
    actions   = ["kinesisanalytics:*"]
    resources = ["arn:${var.partition}:kinesisanalytics:*:*:application/${var.module_customer_namespace}-*"]
  }
}

