//acm.tf
data "aws_iam_policy_document" "acm_pd" {
  statement {
    sid    = "AllowACMView"
    effect = "Allow"

    actions = [
      "acm:Describe*",
      "acm:List*",
      "acm:AddTagsToCertificate",
      "acm:ImportCertificate",
      "acm:RemoveTagsFromCertificate",
      "acm:RequestCertificate",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowACMManagementByNamespaceCondition"
    effect = "Allow"

    actions = [
      "acm:GetCertificate",
      "acm:ResendValidationEmail",
    ]

    resources = [
      "arn:${var.partition}:acm:us-east-1:${var.module_account_id}:certificate/*",
      "arn:${var.partition}:acm:*:${var.module_account_id}:certificate/*",
    ]
  }
}

