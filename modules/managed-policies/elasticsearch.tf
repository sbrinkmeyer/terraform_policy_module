//elastisearch.tf

data "aws_iam_policy_document" "elastisearch_pd" {
  statement {
    effect = "Allow"

    actions = [
      "es:Describe*",
      "es:List*",
      "iam:GetRole",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:PutRolePolicy",
    ]

    resources = ["arn:${var.partition}:iam::*:role/aws-service-role/es.amazonaws.com/AWSServiceRoleForAmazonElasticsearchService"]

    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"

      values = [
        "es.amazonaws.com",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "es:Create*",
      "es:Update*",
      "es:Upgrade*",
      "es:Get*",
      "es:Delete*",
      "es:Add*",
      "es:Remove*",
      "es:ESHttp*",
    ]

    resources = [
      "arn:${var.partition}:es:*:${var.module_account_id}:domain/${var.module_customer_namespace}-*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "es:AddTags",
      "es:RemoveTags",
    ]

    resources = [
      "arn:${var.partition}:es:*:${var.module_account_id}:domain/*",
    ]
  }
}

