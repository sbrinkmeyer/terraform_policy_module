data "aws_iam_policy_document" "xray_pd" {
  statement {
    effect = "Allow"

    actions = [
      "xray:Get*",
      "xray:BatchGetTraces",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "xray:CreateSamplingRule",
      "xray:UpdateSamplingRule",
      "xray:DeleteSamplingRule",
      "xray:CreateGroup",
      "xray:UpdateGroup",
      "xray:DeleteGroup",
    ]

    resources = [ 
      "arn:${var.partition}:xray:*:*:group/${var.module_customer_namespace}-*/*",
      "arn:${var.partition}:xray:*:*:sampling-rule/${var.module_customer_namespace}-*",
    ]
  }
}

