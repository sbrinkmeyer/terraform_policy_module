data "aws_iam_policy_document" "batch_pd" {
  statement {
    actions   = ["batch:*"]
    resources = ["*"]
  }
}

