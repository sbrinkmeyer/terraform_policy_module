//lambda.tf

data "aws_iam_policy_document" "lambda_pd" {
  statement {
    sid     = "allowLambdaToPassAndGetRole"
    effect  = "Allow"
    actions = ["iam:PassRole", "iam:GetRole"]

    resources = [
      "arn:aws:iam::${var.module_account_id}:role/${var.module_tenant_namespace}-*",
      "arn:aws:iam::*:role/lambda_basic_execution",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "lambda:Get*",
      "lambda:List*",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "lambda:AddPermission",
      "lambda:CreateAlias",
      "lambda:CreateEventSourceMapping",
      "lambda:CreateFunction",
      "lambda:DeleteAlias",
      "lambda:DeleteEventSourceMapping",
      "lambda:DeleteFunction",
      "lambda:GetAlias",
      "lambda:GetEventSourceMapping",
      "lambda:GetFunction",
      "lambda:GetFunctionConfiguration",
      "lambda:GetPolicy",
      "lambda:InvokeFunction",
      "lambda:ListAliases",
      "lambda:ListVersionsByFunction",
      "lambda:PublishVersion",
      "lambda:RemovePermission",
      "lambda:UpdateAlias",
      "lambda:UpdateEventSourceMapping",
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionConfiguration",
    ]

    resources = ["arn:aws:lambda:*:*:function:${var.module_tenant_namespace}-*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["kms:ListAliases"]
    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["iam:SimulatePrincipalPolicy"]
    resources = ["*"]
  }

  statement {
    sid    = "EventTriggersForLambda"
    effect = "Allow"

    actions = [
      "events:*",
      "lambda:TagResource",
      "lambda:UntagResource",
      "s3:GetBucketNotification",
      "s3:PutBucketNotification",
    ]

    resources = ["*"]
  }

  // include cloudwatchlogs
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
