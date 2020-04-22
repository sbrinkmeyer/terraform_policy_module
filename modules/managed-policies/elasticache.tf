//elasticache.tf

//seriously just leave it at *
data "aws_iam_policy_document" "elasticache_pd" {
  statement {
    effect = "Allow"

    actions = [
      "cloudwatch:DescribeAlarms",
      "cloudwatch:GetMetricStatistics",
      "elasticache:*",
      "sns:ListSubscriptions",
      "sns:ListTopics",
    ]

    resources = [
      "*",
    ]
  }
}

