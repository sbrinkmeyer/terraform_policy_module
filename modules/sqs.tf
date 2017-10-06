//sqs.tf
data "aws_iam_policy_document" "sqs_pd" {

  statement {
    effect    = "Allow"
    actions   = ["sqs:ListQueues"]
    resources = ["arn:aws:sqs:*:*:*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["sqs:*"]
    resources = ["arn:aws:sqs:*:*:${lower(var.module_tenant_namespace)}-*"]
  }
}
