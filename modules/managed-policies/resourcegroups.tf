data "aws_iam_policy_document" "resourcegroups_pd" {
  statement {
    effect = "Allow"

    actions = ["resource-groups:*"]

    resources = ["*"]
  }
}

