data "aws_iam_policy_document" "ses_pd" {
  statement {
    sid    = "AllowTenantsToSendMailGeneralAccess"
    effect = "Allow"

    actions = [
      "ses:*",
    ]

    resources = ["*"]
  }
}

