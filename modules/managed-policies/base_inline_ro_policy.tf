// base inline policy for ReadOnly SSO Roles
// The permissions in this policy are meant to expand the existing AWS ViewOnly Console role
// adding appropriate, namespaced "describe" policies to namespaced resources

data "aws_iam_policy_document" "ro_base_pd" {
  statement {
    actions = [
      "acm:List*",
      "acm:DescribeCertificate",
    ]

    resources = ["*"]
  }

  statement {
    actions   = ["apigateway:GET"]
    resources = ["*"]
  }

  statement {
    actions = [
      "cloudformation:Describe*",
      "cloudformation:List*",
      "cloudformation:GetStackPolicy",
      "cloudformation:GetTemplate",
    ]

    resources = [
      "arn:${var.partition}:cloudformation:*:${var.module_account_id}:stack/${lower(var.module_customer_namespace)}*",
      "arn:${var.partition}:cloudformation:*:${var.module_account_id}:stack/EC2ContainerService-${lower(var.module_customer_namespace)}*",
      "arn:${var.partition}:cloudformation:*:${var.module_account_id}:stackset/${var.module_customer_namespace}*",
      "arn:${var.partition}:cloudformation:*:${var.module_account_id}:stackset/EC2ContainerService-${var.module_customer_namespace}*",
    ]
  }

  statement {
    sid    = "CFNResourceReadSplat"
    effect = "Allow"

    resources = ["*"]

    actions = [
      "cloudformation:DescribeStacks",
      "cloudformation:EstimateTemplateCost",
      "cloudformation:GetTemplateSummary",
      "cloudformation:ListExports",
      "cloudformation:ListImports",
    ]
  }


  //Dynamodb
  statement {
    actions   = ["dynamodb:List*"]
    resources = ["*"]
  }

  statement {
    actions = [
      "dynamodb:Describe*",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]
    resources = ["arn:${var.partition}:dynamodb:*:*:table/${lower(var.module_customer_namespace)}-*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeTags",
      "ec2:GetConsoleOutput",
      "ec2:GetConsoleScreenshot",
    ]
    resources = ["*"]
  }

  statement {
    actions   = ["ecs:Describe*"]
    resources = ["*"]
  }

  statement {
    actions = ["ecr:Describe*"]

    resources = [
      "arn:${var.partition}:ecr:*:${var.module_account_id}:repository/${lower(var.module_customer_namespace)}*",
    ]
  }

  // EMR doesn't really allow for restricting resources, but can apparently restrict by tag on many items.
  // Reference on what can and can't have a condition: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-access-iam.html#emr-fine-grained-cluster-access
  statement {
    sid       = "EMRConditionalActions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticmapreduce:DescribeCluster",
      "elasticmapreduce:DescribeStep",
      "elasticmapreduce:ListBootstrapActions",
      "elasticmapreduce:ListInstanceGroups",
      "elasticmapreduce:ListInstances",
      "elasticmapreduce:ListSteps",
    ]

    condition {
      test     = "StringLike"
      variable = "elasticmapreduce:ResourceTag/Name"
      values   = ["${var.module_customer_namespace}-*"]
    }
  }

  //EMR RO actions that can't have conditions...
  statement {
    sid       = "EMRNonConditionalActions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticmapreduce:DescribeSecurityConfiguration",
      "elasticmapreduce:ListClusters",
      "elasticmapreduce:ListSecurityConfigurations",
      "elasticmapreduce:ViewEventsFromAllClustersInConsole",
    ]
  }

  statement {
    actions   = ["elasticfilesystem:Describe*"]
    resources = ["*"]
  }

  statement {
    actions   = ["elasticache:Describe*"]
    resources = ["*"]
  }

  statement {
    actions   = ["elasticbeanstalk:Describe*"]
    resources = ["*"]
  }

  statement {
    actions   = ["elasticloadbalancing:Describe*"]
    resources = ["*"]
  }

  // cloudwatch events API
  statement {
    actions = [
      "events:List*",
      "events:Describe*",
      "events:TestEventPattern",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "firehose:DescribeDeliveryStream",
      "firehose:ListDeliveryStreams",
      "kinesis:DescribeLimits",
      "kinesis:ListShards",
      "kinesis:ListStreams",
      "kinesisanalytics:ListApplications",
      "kinesisvideo:DescribeStream",
      "kinesisvideo:ListStreams",
    ]

    resources = ["*"]
  }

  statement {
    actions   = ["kinesis:Describe*"]
    resources = ["arn:${var.partition}:kinesis:*:*:stream/${lower(var.module_customer_namespace)}*"]
  }

  statement {
    actions = [
      "kms:ListAliases",
      "kms:DescribeKey",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "lambda:GetAccountSettings",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "lambda:Describe*",
      "lambda:Get*",
    ]

    resources = ["arn:${var.partition}:lambda:*:*:function:${lower(var.module_customer_namespace)}-*"]
  }

  statement {
    actions = [
      "rds:Describe*",
      "rds:ListTagsForResource",
    ]

    resources = ["*"]
  }

  statement {
    actions   = ["rds:Download*"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "rds:db-tag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

  statement {
    actions   = ["rds:Download*"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "rds:db-tag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

  statement {
    actions   = ["rds:Download*"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "rds:db-tag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

  statement {
    actions = [
      "s3:List*",
      "s3:Get*",
    ]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-${lower(var.module_target_moniker)}-${var.module_target_region}",
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-${lower(var.module_target_moniker)}-${var.module_target_region}/*",
    ]
  }

  // AAA JWT Key Management SVCS
  // https://confluence.business.com/display/SECDEV/BUSINESS+JWT+Reference+Guide

  // Allows tenants to list objects in public-keys and their private-keys subdirectory
  statement {
    sid       = "AccessToAAAKeyBucketSubfolders"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:${var.partition}:s3:::internal.thecommons*"]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "",
        "private-keys/",
        "private-keys/${var.module_customer_namespace}/*",
        "public-keys/*",
      ]
    }
  }

  // Allow tenants to get objects in public-keys and their subdirectory
  statement {
    sid     = "AccessToAAAKeyObjects"
    effect  = "Allow"
    actions = ["s3:GetObject"]

    resources = [
      "arn:${var.partition}:s3:::internal.thecommons*/private-keys/${var.module_customer_namespace}/*",
      "arn:${var.partition}:s3:::internal.thecommons*/public-keys/*",
    ]
  }

  //SQS allow console to get attributes of an SQS queue
  statement {
    effect    = "Allow"
    actions   = ["sqs:ListQueues"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListQueueTags",
    ]
    resources = ["arn:${var.partition}:sqs:*:*:${lower(var.module_customer_namespace)}-*"]
  }

  statement {
    actions = [
      "mq:List*",
      "mq:Describe*",
    ]

    resources = ["arn:${var.partition}:mq:*:${var.module_account_id}:*"]
  }

  statement {
    actions   = ["tag:getResources"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ses:Get*",
      "ses:Describe*",
    ]

    resources = ["*"]
  }

  // Translate
  statement {
    sid    = "Translate"
    effect = "Allow"

    actions = [
      "translate:TranslateText",
    ]

    resources = ["*"]
  }

  // health dashboard (for console users)
  statement {
    effect    = "Allow"
    actions   = ["health:Describe*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "sts:DecodeAuthorizationMessage",
    ]

    resources = ["*"]
  }

  // DMS
  statement {
    effect = "Allow"
    actions = [
      "dms:Describe*",
      "dms:ListTagsForResource",
    ]
    resources = ["*"]
  }

  // StepFunctions
  statement {
    sid    = "StepFunctionsSplatPermissions"
    effect = "Allow"

    actions = [
      "states:ListActivities",
      "states:ListStateMachines",
      "states:ListTagsForResource",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "StepFunctionsResourceBasedPermissions"
    effect = "Allow"

    actions = [
      "states:Describe*",
      "states:ListExecutions",
      "states:GetExecutionHistory",
    ]

    resources = [
      "arn:${var.partition}:states:*:${var.module_account_id}:stateMachine:${var.module_customer_namespace}-*",
      "arn:${var.partition}:states:*:${var.module_account_id}:activity:${var.module_customer_namespace}-*",
      "arn:${var.partition}:states:*:${var.module_account_id}:execution:${var.module_customer_namespace}-*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "es:Get*",
    ]

    resources = [
      "arn:${var.partition}:es:*:${var.module_account_id}:domain/${var.module_customer_namespace}-*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "pi:Describe*",
      "pi:Get*",
    ]

    resources = [
      "arn:${var.partition}:pi:*:*:metrics/*/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "xray:Get*",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "eks:List*",
      "eks:Describe*",
    ]

    resources = ["*"]
  }

}
