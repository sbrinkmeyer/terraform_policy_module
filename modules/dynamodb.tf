//dynamodb.tf
data "aws_iam_policy_document" "dynamodb_pd" {
  statement {
    sid    = "DynamodbConsoleROAccess"
    effect = "Allow"

    actions = [
      "autoscaling:Describe*",
      "logs:Get*",
      "logs:Describe*",
      "logs:TestMetricFilter",
      "sns:Get*",
      "sns:List*",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "datapipeline:Describe*",
      "datapipeline:GetPipelineDefinition",
      "datapipeline:ListPipelines",
      "datapipeline:QueryObjects",
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:ListTables",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:ListTagsOfResource",
      "dynamodb:DescribeTimeToLive",
      "lambda:ListFunctions",
      "lambda:ListEventSourceMappings",
      "lambda:GetFunctionConfiguration",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:CreateTable",
      "dynamodb:DeleteItem",
      "dynamodb:DeleteTable",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:GetItem",
      "dynamodb:ListTagsOfResource",
      "dynamodb:PutItem",
      "dynamodb:TagResource",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable",
      "dynamodb:UpdateTimeToLive",
      "dynamodb:UntagResource",
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/${lower(var.module_tenant_namespace)}-*",
      "arn:aws:dynamodb:*:*:table/entsvcs-terraform*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams",
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/${lower(var.module_tenant_namespace)}-*/stream/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:ListTables",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Query",
      "dynamodb:Scan",
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/${lower(var.module_tenant_namespace)}-*",
      "arn:aws:dynamodb:*:*:table/${lower(var.module_tenant_namespace)}-*/index/*",
      "arn:aws:dynamodb:*:*:table/entsvcs-terraform*",
      "arn:aws:dynamodb:*:*:table/entsvcs-terraform*/index/*",
    ]
  }

  statement {
    effect = "Deny"

    actions = [
      "dynamodb:DeleteTable",
      "dynamodb:TagResource",
      "dynamodb:UpdateTable",
      "dynamodb:UntagResource",
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/entsvcs-terraform*",
    ]
  }

  statement {
    sid    = "AllowCloudWatchSupport"
    effect = "Allow"

    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms",
    ]

    resources = ["*"]
  }
}
