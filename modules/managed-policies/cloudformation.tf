//cloudformation.tf
data "aws_iam_policy_document" "cloudformation_pd" {
  statement {
    sid    = "CFNResourceBasedPermissions"
    effect = "Allow"

    resources = [
      "arn:${var.partition}:cloudformation:*:${var.module_account_id}:stack/${var.module_customer_namespace}*",
      "arn:${var.partition}:cloudformation:*:${var.module_account_id}:stack/EC2ContainerService-${var.module_customer_namespace}*",
      "arn:${var.partition}:cloudformation:*:${var.module_account_id}:stackset/${var.module_customer_namespace}*",
      "arn:${var.partition}:cloudformation:*:${var.module_account_id}:stackset/EC2ContainerService-${var.module_customer_namespace}*",
      "arn:${var.partition}:cloudformation:::aws:transform/Serverless-2016-10-31",
    ]

    actions = [
      "cloudformation:CancelUpdateStack",
      "cloudformation:ContinueUpdateRollback",
      "cloudformation:CreateChangeSet",
      "cloudformation:CreateStack",
      "cloudformation:CreateStackInstances",
      "cloudformation:DeleteChangeSet",
      "cloudformation:DeleteStack",
      "cloudformation:DeleteStackInstances",
      "cloudformation:DeleteStackSet",
      "cloudformation:Describe*",
      "cloudformation:DetectStackDrift",
      "cloudformation:DetectStackResourceDrift",
      "cloudformation:ExecuteChangeSet",
      "cloudformation:GetStackPolicy",
      "cloudformation:GetTemplate",
      "cloudformation:List*",
      "cloudformation:SetStackPolicy",
      "cloudformation:SignalResource",
      "cloudformation:StopStackSetOperation",
      "cloudformation:UpdateStack",
      "cloudformation:UpdateStackInstances",
      "cloudformation:UpdateStackSet",
      "cloudformation:UpdateTerminationProtection",
    ]
  }

  statement {
    sid       = "CFNResourceSplat"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cloudformation:CreateStackSet",
      "cloudformation:DescribeAccountLimits",
      "cloudformation:DescribeStacks",
      "cloudformation:DescribeStackDriftDetectionStatus",
      "cloudformation:EstimateTemplateCost",
      "cloudformation:GetTemplateSummary",
      "cloudformation:ListImports",
      "cloudformation:ListExports",
      "cloudformation:ListStacks",
      "cloudformation:PreviewStackUpdate",
      "cloudformation:ValidateTemplate",
    ]
  }

  statement {
    sid    = "CloudWatchLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLog*",
      "logs:Delete*",
      "logs:Describe*",
      "logs:FilterLogEvents",
      "logs:Get*",
      "logs:List*",
      "logs:Put*",
      "logs:TagLogGroup",
      "logs:TestMetricFilter",
      "logs:UntagLogGroup",
      "logs:StartQuery",
      "logs:StopQuery",
    ]

    // resources = [ "arn:${var.partition}:logs:*:*:${var.module_customer_namespace}*" ]
    resources = ["*"]
  }
}

