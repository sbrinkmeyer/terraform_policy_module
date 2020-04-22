//apigateway.tf

data "aws_iam_policy_document" "apigateway_pd" {
  statement {
    sid       = "AllowCloudFrontUpdateDistribution"
    effect    = "Allow"
    actions   = ["cloudfront:updateDistribution"]
    resources = ["*"]
  }

  statement {
    sid    = "DenyToEverythingElse"
    effect = "Allow"

    actions = [
      "apigateway:DELETE",
    ]

    resources = [
      "arn:${var.partition}:apigateway:*::${var.module_customer_namespace}*",
      "arn:${var.partition}:apigateway:*::/${var.module_customer_namespace}*",
      "arn:${var.partition}:apigateway:*::/account/${var.module_customer_namespace}*",
      "arn:${var.partition}:apigateway:*::/clientcertificates/${var.module_customer_namespace}*",
      "arn:${var.partition}:apigateway:*::/domainnames/${var.module_customer_namespace}*",
      "arn:${var.partition}:apigateway:*::/apikeys/${var.module_customer_namespace}*",
      "arn:${var.partition}:apigateway:*::/restapis/${var.module_customer_namespace}*/*",
    ]
  }

  // statement {
  //     sid="DenyToRootEntries"
  //     effect="Deny"
  //     actions=[
  //         "apigateway:GET",
  //         "apigateway:HEAD",
  //         "apigateway:OPTIONS"
  //     ]
  //     resources = [
  //             "arn:${var.partition}:apigateway:*::/",
  //             "arn:${var.partition}:apigateway:*::/account",
  //             "arn:${var.partition}:apigateway:*::/clientcertificates",
  //             "arn:${var.partition}:apigateway:*::/domainnames",
  //             "arn:${var.partition}:apigateway:*::/apikeys"
  //         ]
  // }
  // statement {
  //     sid="APIGatewayManagedAccess"
  //     effect="Allow"
  //     actions=[
  //         "apigateway:*"
  //     ]
  //     resources=[
  //         "arn:${var.partition}:apigateway:*::${var.module_customer_namespace}*",
  //         "arn:${var.partition}:apigateway:*::/${var.module_customer_namespace}*",
  //         "arn:${var.partition}:apigateway:*::/account/${var.module_customer_namespace}*",
  //         "arn:${var.partition}:apigateway:*::/clientcertificates/${var.module_customer_namespace}*",
  //         "arn:${var.partition}:apigateway:*::/domainnames/${var.module_customer_namespace}*",
  //         "arn:${var.partition}:apigateway:*::/apikeys/${var.module_customer_namespace}*",
  //         "arn:${var.partition}:apigateway:*::/restapis/${var.module_customer_namespace}*/*"
  //     ]
  // }
  statement {
    sid       = "allowgatewayageddon"
    effect    = "Allow"
    actions   = ["apigateway:*"]
    resources = ["arn:${var.partition}:apigateway:*::/*"]
  }

  statement {
    // this should be a separate policy to only attach to apigw service role so new role doesn't have too much power
    sid       = "APIGatewayInvokeLambda"
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction"]
    resources = ["arn:${var.partition}:lambda:*:*:function:${var.module_customer_namespace}-*"]
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

  statement {
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
    actions = [
      "acm:GetCertificate",
      "acm:ResendValidationEmail",
    ]

    resources = [
      "arn:${var.partition}:acm:us-east-1:${var.module_account_id}:certificate/*",
      "arn:${var.partition}:acm:*:${var.module_account_id}:certificate/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:PutRolePolicy",
    ]

    resources = ["arn:${var.partition}:iam::*:role/aws-service-role/ops.apigateway.amazonaws.com/AWSServiceRoleForAPIGateway"]

    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"

      values = [
        "ops.apigateway.amazonaws.com",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "execute-api:*",
    ]

    resources = ["*"]
  }
}

