//cloudwatchlogs.tf

data "aws_iam_policy_document" "cloudwatchlogs_pd" {
  statement {
    sid    = "CloudWatchLogs"
    effect = "Allow"

    actions = [
      "cloudwatch:PutMetricData",
      "logs:CreateLog*",
      "logs:Delete*",
      "logs:Describe*",
      "logs:FilterLogEvents",
      "logs:Get*",
      "logs:List*",
      "logs:Put*",
      "logs:TagLogGroup",
      "logs:TestMetricFilter",
      "logs:UntagLogGroup",
      "logs:StartQuery",
      "logs:StopQuery",
    ]

    resources = ["*"]
  }
}

