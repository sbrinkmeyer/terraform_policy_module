data "aws_iam_policy_document" "glue_pd" {
  statement {
    actions   = ["glue:*"]
    resources = ["*"]
  }

  statement {
    actions   = ["athena:*"]
    resources = ["*"]
  }
}

