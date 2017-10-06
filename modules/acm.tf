//acm.tf
data "aws_iam_policy_document" "acm_pd" {
  statement {
    sid    = "AllowACMView"
    effect = "Allow"

    actions = [
      "acm:Describe*",
      "acm:List*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowACMManagementSplatResNamespaceCondition"
    effect = "Allow"

    actions = [
      "acm:AddTagsToCertificate",
      "acm:ImportCertificate",
      "acm:RemoveTagsFromCertificate",
      "acm:RequestCertificate",
    ]

    resources = ["*"]

    // condition {
    //     test = "StringLike"
    //     variable = "aws:userid"
    //     values = [ "*${lower(var.module_tenant_namespace)}*" ]
    // }
  }

  statement {
    sid    = "AllowACMManagementByNamespaceCondition"
    effect = "Allow"

    actions = [
      // "acm:DeleteCertificate",
      "acm:GetCertificate",

      "acm:ResendValidationEmail",
    ]

    resources = [
      "arn:aws:acm:us-east-1:${var.module_account_id}:certificate/*",
      "arn:aws:acm:*:${var.module_account_id}:certificate/*",
    ]

    // condition {
    //     test = "StringLike"
    //     variable = "aws:userid"
    //     values = [ "*${lower(var.module_tenant_namespace)}*" ]
    // }
  }
}
