//sns.tf
data "aws_iam_policy_document" "sns_pd" {
  statement {
    sid    = "SNSResourceBasedPermissions"
    effect = "Allow"

    actions = [
      "sns:AddPermission",
      "sns:CheckIfPhoneNumberIsOptedOut",
      "sns:ConfirmSubscription",
      "sns:Create*",
      "sns:Delete*",
      "sns:Get*",
      "sns:OptInPhoneNumber",
      "sns:Publish",
      "sns:RemovePermission",
      "sns:Set*",
      "sns:Subscribe",
      "sns:Unsubscribe",
    ]

    resources = [
      "arn:aws:sns:*:${var.module_account_id}:${lower(var.module_tenant_namespace)}-*",
    ]
  }

  statement {
    sid       = "SNSSplatPermissions"
    effect    = "Allow"
    actions   = ["sns:List*"]
    resources = ["*"]
  }
}
