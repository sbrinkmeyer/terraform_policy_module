//sns.tf
data "aws_iam_policy_document" "sns_pd" {
  statement {
    sid    = "SNSResourceBasedPermissions"
    effect = "Allow"
    actions = [
      "sns:AddPermission",
      "sns:ConfirmSubscription",
      "sns:CreateTopic",
      "sns:DeleteTopic",
      "sns:GetTopicAttributes",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTagsForResource",
      "sns:Publish",
      "sns:RemovePermission",
      "sns:SetTopicAttributes",
      "sns:Subscribe",
      "sns:TagResource",
      "sns:UntagResource",
    ]
    resources = concat(
      list("arn:${var.partition}:sns:*:${var.module_account_id}:${lower(var.module_customer_namespace)}-*"),
      var.sns_arns,
    )
  }

  statement {
    sid    = "SNSSplatPermissions"
    effect = "Allow"
    actions = [
      "sns:CheckIfPhoneNumberIsOptedOut",
      "sns:CreatePlatformApplication",
      "sns:CreatePlatformEndpoint",
      "sns:DeleteEndpoint",
      "sns:DeletePlatformApplication",
      "sns:GetEndpointAttributes",
      "sns:GetPlatformApplicationAttributes",
      "sns:GetSMSAttributes",
      "sns:GetSubscriptionAttributes",
      "sns:ListEndpointsByPlatformApplication",
      "sns:ListPhoneNumbersOptedOut",
      "sns:ListPlatformApplications",
      "sns:ListSubscriptions",
      "sns:ListTopics",
      "sns:OptInPhoneNumber",
      "sns:SetEndpointAttributes",
      "sns:SetPlatformApplicationAttributes",
      "sns:SetSubscriptionAttributes",
      "sns:Unsubscribe",
    ]
    resources = ["*"]
  }
}

