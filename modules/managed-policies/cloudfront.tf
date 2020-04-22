//cloudfront.tf
data "aws_iam_policy_document" "cloudfront_pd" {
  // they need the s3, cloudwatch,
  statement {
    sid       = "cloudfrontForConsole"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "acm:ListCertificates",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTopics",
      "waf:GetWebACL",
      "waf:ListWebACLs",
    ]
  }

  statement {
    sid       = "cloudfrontAccess"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cloudfront:*",
    ]
  }
}

