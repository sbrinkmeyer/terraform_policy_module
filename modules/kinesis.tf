//kinesis.tf
data "aws_iam_policy_document" "kinesis_pd" {
  statement {
    sid       = "AllowKinesisManagementByNamespace"
    effect    = "Allow"
    actions   = ["kinesis:*"]
    resources = ["arn:aws:kinesis:*:*:stream/${var.module_tenant_namespace}*"]
  }
}
