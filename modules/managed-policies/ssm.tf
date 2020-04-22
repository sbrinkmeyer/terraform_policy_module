//ssm.tf

data "aws_iam_policy_document" "ssm_pd" {
  statement {
    sid    = "AllowFullDescribeAccess"
    effect = "Allow"

    actions = [
      "ssm:Describe*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowSSMAutomationAccess"
    effect = "Allow"

    actions = [
      "ssm:CancelCommand",
      "ssm:Create*",
      "ssm:Delete*",
      "ssm:Deregister*",
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
      "ssm:Put*",
      "ssm:Register*",
      "ssm:Send*",
      "ssm:StartAutomationExecution",
      "ssm:StopAutomationExecution",
      "ssm:Update*",
    ]

    resources = [
      "arn:${var.partition}:ssm:*:${var.module_account_id}:automation-execution/${var.module_customer_namespace}*",
      "arn:${var.partition}:ssm:*:${var.module_account_id}:automation-definition/${var.module_customer_namespace}*",
    ]
  }

  statement {
    sid    = "AllowSSMDocumentAccess"
    effect = "Allow"

    actions = [
      "ssm:Create*",
      "ssm:Delete*",
      "ssm:Deregister*",
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
      "ssm:Put*",
      "ssm:Register*",
      "ssm:Send*",
      "ssm:Update*",
    ]

    resources = [
      "arn:${var.partition}:ssm:*:${var.module_account_id}:document/${var.module_customer_namespace}*",
    ]
  }

  statement {
    sid    = "AllowSSMParameterStoreAccess"
    effect = "Allow"

    actions = [
      "ssm:AddTagsToResource",
      "ssm:Create*",
      "ssm:Delete*",
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
      "ssm:Put*",
      "ssm:RemoveTagsFromResource",
      "ssm:Update*",
    ]

    resources = [
      "arn:${var.partition}:ssm:*:${var.module_account_id}:parameter/${var.module_customer_namespace}*",
    ]
  }

  statement {
    sid    = "AllowSSMPatchingAccess"
    effect = "Allow"

    actions = [
      "ssm:Create*",
      "ssm:Delete*",
      "ssm:Deregister*",
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
      "ssm:Put*",
      "ssm:Register*",
      "ssm:Update*",
    ]

    resources = [
      "arn:${var.partition}:ssm:*:${var.module_account_id}:patchbaseline/${var.module_customer_namespace}*",
    ]
  }

  statement {
    sid    = "AllowSSMMaintenanceAccess"
    effect = "Allow"

    actions = [
      "ssm:Create*",
      "ssm:Delete*",
      "ssm:Deregister*",
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
      "ssm:Put*",
      "ssm:Register*",
      "ssm:Send*",
      "ssm:Update*",
    ]

    resources = [
      "arn:${var.partition}:ssm:*:${var.module_account_id}:maintenancewindows/${var.module_customer_namespace}*",
    ]
  }

  statement {
    sid    = "AllowSSMManagedInstancesAccess"
    effect = "Allow"

    actions = [
      "ssm:AddTagsToResource",
      "ssm:CancelCommand",
      "ssm:Create*",
      "ssm:Delete*",
      "ssm:Deregister*",
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
      "ssm:Put*",
      "ssm:Register*",
      "ssm:RemoveTagsFromResource",
      "ssm:Send*",
      "ssm:Update*",
    ]

    resources = [
      "arn:${var.partition}:ssm:*:${var.module_account_id}:managed-instance/${var.module_customer_namespace}*",
      "arn:${var.partition}:ssm:*:${var.module_account_id}:managed-instance-inventory/${var.module_customer_namespace}*",
    ]
  }
}

