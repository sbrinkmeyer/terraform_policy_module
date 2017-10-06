//cloudformation.tf
data "aws_iam_policy_document" "cloudformation_pd" {
  statement {
    sid    = "CFNResourceBasedPermissions"
    effect = "Allow"

    resources = [
      "arn:aws:cloudformation:*:${var.module_account_id}:stack/${var.module_tenant_namespace}*",
    ]

    actions = [
      "cloudformation:CancelUpdateStack",
      "cloudformation:ContinueUpdateRollbacks",
      "cloudformation:CreateChangeSets",
      "cloudformation:CreateStack",
      "cloudformation:DeleteStack",
      "cloudformation:DescribeStackEvents",
      "cloudformation:DescribeStackResource",
      "cloudformation:DescribeStackResources",
      "cloudformation:DescribeStacks",
      "cloudformation:ExecuteChangeSets",
      "cloudformation:GetStackPolicy",
      "cloudformation:GetTemplates",
      "cloudformation:GetTemplateSummarys",
      "cloudformation:ListChangeSets",
      "cloudformation:ListStackResources",
      "cloudformation:SetStackPolicy",
      "cloudformation:SignalResources",
      "cloudformation:UpdateStack",
    ]
  }

  statement {
    sid       = "CFNResourceSplat"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cloudformation:DescribeAccountLimits",
      "cloudformation:DescribeChangeSet",
      "cloudformation:EstimateTemplateCost",
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
    ]

    // resources = [ "arn:aws:logs:*:*:${var.module_tenant_namespace}*" ]
    resources = ["*"]
  }
}
