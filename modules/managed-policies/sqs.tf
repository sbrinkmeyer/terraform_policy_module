//sqs.tf
data "aws_iam_policy_document" "sqs_pd" {
  statement {
    effect    = "Allow"
    actions   = ["sqs:ListQueues"]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["sqs:*"]
    resources = ["arn:${var.partition}:sqs:*:*:${lower(var.module_customer_namespace)}-*"]
  }
}

