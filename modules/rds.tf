//rds.tf
data "aws_iam_policy_document" "rds_pd" {
  statement {
    sid       = "AllowRDSDescribe"
    effect    = "Allow"
    actions   = ["rds:Describe*"]
    resources = ["*"]
  }

  statement {
    sid     = "AllowRDSManagementByNamespace"
    effect  = "Allow"
    actions = ["rds:*"]

    resources = [
      "arn:aws:rds:*:*:*:${lower(var.module_tenant_namespace)}.*",
      "arn:aws:rds:*:*:*:${lower(var.module_tenant_namespace)}*",
      "arn:aws:rds:*:*:cluster-pg*",
      "arn:aws:rds:*:*:subgrp:*",
      "arn:aws:rds:*:*:pg*",
    ]
  }
}
