//dynamodb.tf
data "aws_iam_policy_document" "dynamodb_pd" {
  statement {
    effect = "Allow"
    actions = [
      "application-autoscaling:*",
      "datapipeline:DescribeObjects",
      "datapipeline:DescribePipelines",
      "datapipeline:GetPipelineDefinition",
      "datapipeline:ListPipelines",
      "datapipeline:QueryObjects",
      "dax:CreateCluster",
      "dax:CreateParameterGroup",
      "dax:CreateParameterGroup",
      "dax:CreateSubnetGroup",
      "dax:CreateSubnetGroup",
      "dax:DecreaseReplicationFactor",
      "dax:DeleteCluster",
      "dax:DeleteParameterGroup",
      "dax:DeleteSubnetGroup",
      "dax:DescribeClusters",
      "dax:DescribeDefaultParameters",
      "dax:DescribeEvents",
      "dax:DescribeParameterGroups",
      "dax:DescribeParameters",
      "dax:DescribeSubnetGroups",
      "dax:IncreaseReplicationFactor",
      "dax:ListTags",
      "dax:RebootNode",
      "dax:TagResource",
      "dax:UntagResource",
      "dax:UpdateCluster",
      "dax:UpdateParameterGroup",
      "dax:UpdateSubnetGroup",
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeBackup",
      "dynamodb:DescribeContinuousBackups",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:GetItem",
      "dynamodb:ListBackups",
      "dynamodb:ListTables",
      "dynamodb:ListTagsOfResource",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "iam:GetRole",
      "lambda:GetFunctionConfiguration",
      "lambda:ListEventSourceMappings",
      "lambda:ListFunctions",
      "sns:ListSubscriptions",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTopics",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole",
    ]
    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}-*",
      "arn:${var.partition}:iam::*:role/lambda_basic_execution",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "dax:BatchGetItem",
      "dax:BatchWriteItem",
      "dax:DeleteItem",
      "dax:DescribeTable",
      "dax:GetItem",
      "dax:ListTables",
      "dax:PutItem",
      "dax:Query",
      "dax:Scan",
      "dax:UpdateItem",
    ]
    resources = ["arn:${var.partition}:dax:*:${var.module_account_id}:cache/${lower(var.module_customer_namespace)}-*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:CreateTable",
      "dynamodb:DeleteItem",
      "dynamodb:DeleteTable",
      "dynamodb:DescribeContinuousBackups",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:GetItem",
      "dynamodb:ListTagsOfResource",
      "dynamodb:PutItem",
      "dynamodb:TagResource",
      "dynamodb:UpdateContinuousBackups",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable",
      "dynamodb:UpdateTimeToLive",
      "dynamodb:UntagResource",
      "dynamodb:ListBackups",
      "dynamodb:CreateBackup",
      "dynamodb:RestoreTableFromBackup",
      "dynamodb:CreateGlobalTable",
      "dynamodb:DescribeGlobalTable",
      "dynamodb:DescribeLimits",
      "dynamodb:UpdateGlobalTable",
    ]

    resources = [
      "arn:${var.partition}:dynamodb:*:*:table/${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:dynamodb:*:*:global-table/${lower(var.module_customer_namespace)}-*",
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
      "arn:${var.partition}:dynamodb:*:*:table/${lower(var.module_customer_namespace)}-*/stream/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
    ]

    resources = [
      "arn:${var.partition}:dynamodb:*:*:table/${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:dynamodb:*:*:table/${lower(var.module_customer_namespace)}-*/index/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
    ]

    resources = [
      "arn:${var.partition}:dynamodb:*:*:table/entsvcs-terraform*",
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"

      values = [
        "replication.dynamodb.amazonaws.com",
        "dax.amazonaws.com",
        "dynamodb.application-autoscaling.amazonaws.com",
      ]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["arn:${var.partition}:iam::${var.module_account_id}:role/aws-service-role/dynamodb.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_DynamoDBTable"]
  }
}

