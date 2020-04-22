//sdb.tf
data "aws_iam_policy_document" "sdb_pd" {
  statement {
    effect    = "Allow"
    actions   = ["sdb:ListDomains"]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["sdb:*"]
    resources = ["arn:${var.partition}:sdb:*:*:domain/${lower(var.module_customer_namespace)}-*"]
  }
}

