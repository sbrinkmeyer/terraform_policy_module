//cloudwatchlogs.tf

data "aws_iam_policy_document" "cloudwatchlogs_pd" {
  statement {
    sid    = "CloudWatchLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLog*",
      "logs:Delete*",
      "logs:Describe*",
      "logs:FilterLogEvents",
      "logs:Get*",
      "logs:List*",
      "logs:Put*",
      "logs:TagLogGroup",
      "logs:TestMetricFilter",
    ]

    // resources = [ "arn:aws:logs:*:*:${var.module_tenant_namespace}*" ]
    resources = ["*"]
  }
}
