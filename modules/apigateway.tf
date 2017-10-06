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
      "arn:aws:apigateway:*::${var.module_tenant_namespace}*",
      "arn:aws:apigateway:*::/${var.module_tenant_namespace}*",
      "arn:aws:apigateway:*::/account/${var.module_tenant_namespace}*",
      "arn:aws:apigateway:*::/clientcertificates/${var.module_tenant_namespace}*",
      "arn:aws:apigateway:*::/domainnames/${var.module_tenant_namespace}*",
      "arn:aws:apigateway:*::/apikeys/${var.module_tenant_namespace}*",
      "arn:aws:apigateway:*::/restapis/${var.module_tenant_namespace}*/*",
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
  //             "arn:aws:apigateway:*::/",
  //             "arn:aws:apigateway:*::/account",
  //             "arn:aws:apigateway:*::/clientcertificates",
  //             "arn:aws:apigateway:*::/domainnames",
  //             "arn:aws:apigateway:*::/apikeys"
  //         ]
  // }
  // statement {
  //     sid="APIGatewayManagedAccess"
  //     effect="Allow"
  //     actions=[
  //         "apigateway:*"
  //     ]
  //     resources=[
  //         "arn:aws:apigateway:*::${var.module_tenant_namespace}*",
  //         "arn:aws:apigateway:*::/${var.module_tenant_namespace}*",
  //         "arn:aws:apigateway:*::/account/${var.module_tenant_namespace}*",
  //         "arn:aws:apigateway:*::/clientcertificates/${var.module_tenant_namespace}*",
  //         "arn:aws:apigateway:*::/domainnames/${var.module_tenant_namespace}*",
  //         "arn:aws:apigateway:*::/apikeys/${var.module_tenant_namespace}*",
  //         "arn:aws:apigateway:*::/restapis/${var.module_tenant_namespace}*/*"
  //     ]
  // }
  statement {
    sid       = "allowgatewayageddon"
    effect    = "Allow"
    actions   = ["apigateway:*"]
    resources = ["arn:aws:apigateway:*::/*"]
  }

  statement {
    // this should be a separate policy to only attach to apigw service role so new role doesn't have too much power
    sid       = "APIGatewayInvokeLambda"
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction"]
    resources = ["arn:aws:lambda:*:*:function:${var.module_tenant_namespace}-*"]
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
