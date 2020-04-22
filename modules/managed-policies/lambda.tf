//lambda.tf

data "aws_iam_policy_document" "lambda_pd" {
  statement {
    sid     = "allowLambdaToPassAndGetRole"
    effect  = "Allow"
    actions = ["iam:PassRole", "iam:GetRole"]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}-*",
      "arn:${var.partition}:iam::*:role/lambda_basic_execution",
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

    // lambda:UntagResources* is from an AWS bug.  Source https://github.com/terraform-providers/terraform-provider-aws/issues/5846
    actions = [
      "lambda:AddPermission",
      "lambda:CreateAlias",
      "lambda:CreateEventSourceMapping",
      "lambda:CreateFunction",
      "lambda:DeleteAlias",
      "lambda:DeleteEventSourceMapping",
      "lambda:DeleteFunction",
      "lambda:DeleteFunctionConcurrency",
      "lambda:DeleteProvisionedConcurrencyConfig",
      "lambda:GetAlias",
      "lambda:GetEventSourceMapping",
      "lambda:GetFunction",
      "lambda:GetFunctionConfiguration",
      "lambda:GetPolicy",
      "lambda:InvokeFunction",
      "lambda:ListAliases",
      "lambda:ListVersionsByFunction",
      "lambda:PublishVersion",
      "lambda:PutFunctionConcurrency",
      "lambda:PutProvisionedConcurrencyConfig",
      "lambda:RemovePermission",
      "lambda:TagResource",
      "lambda:UntagResource",
      "lambda:UntagResources*",
      "lambda:UpdateAlias",
      "lambda:UpdateEventSourceMapping",
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionConfiguration",
    ]

    resources = ["arn:${var.partition}:lambda:*:*:function:${var.module_customer_namespace}-*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "lambda:CreateEventSourceMapping",
      "lambda:DeleteEventSourceMapping",
      "lambda:UpdateEventSourceMapping",
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "lambda:FunctionArn"

      values = [
        "arn:${var.partition}:lambda:*:*:function:${var.module_customer_namespace}-*",
      ]
    }
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
      "cloudwatch:PutMetricData",
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

  // fixes the eni depletion
  statement {
    sid    = "EC2ActionsAllowSplat"
    effect = "Allow"
    actions = [
      "autoscaling:CompleteLifecycleAction",
      "ec2:AttachNetworkInterface",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DetachNetworkInterface",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:ResetNetworkInterfaceAttribute",
    ]
    resources = ["*"]
  }

  // Layers actions
  statement {
    effect = "Allow"
    actions = [
      "lambda:ListLayers",
      "lambda:ListLayerVersions",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "lambda:PublishLayerVersion",
    ]
    resources = ["arn:${var.partition}:lambda:*:${var.module_account_id}:layer:${var.module_customer_namespace}-*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "lambda:AddLayerVersionPermission",
      "lambda:RemoveLayerVersionPermission",
      "lambda:GetLayerVersion",
      "lambda:GetLayerVersionPolicy",
      "lambda:DeleteLayerVersion",
    ]
    resources = ["arn:${var.partition}:lambda:*:${var.module_account_id}:layer:${var.module_customer_namespace}-*:*"]
  }
}
