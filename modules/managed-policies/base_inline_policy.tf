//base_inline_policy.tf

data "aws_iam_policy_document" "base_pd" {
  //clould formation policy start
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


  //clouldformation policy end

  //ec2 policy broken out to ec2.tf.

  // health dashboard (for console users)
  statement {
    effect    = "Allow"
    actions   = ["health:Describe*"]
    resources = ["*"]
  }

  // iam always policy start

  statement {
    // sid = "DeniedPolicies"
    effect = "Deny"

    actions = [
      "iam:CreatePolic*",
      "iam:DeletePolic*",
      "iam:SetDefaultPolicyVersion",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    // sid = "ListAllPolicies"
    effect = "Allow"

    actions = [
      "iam:GetAccount*",
      "iam:GetRole",
      "iam:List*",
      "iam:DescribeCertificate",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    // sid = "EC2IAMPassroleToInstance"
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
    // sid = "IAMServerCertificatePermissions"
    effect = "Allow"

    actions = [
      "iam:UploadServerCertificate",
      "iam:DeleteServerCertificate",
      "iam:UpdateServerCertificate",
      "iam:GetServerCertificate",
    ]

    resources = ["arn:${var.partition}:iam::${var.module_account_id}:server-certificate/${var.module_customer_namespace}-*"]
  }
  statement {
    // sid = "AllowedNSPolicies"
    effect = "Allow"

    actions = [
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
    ]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:policy/${var.module_customer_namespace}-*",
      "arn:${var.partition}:iam::aws:policy/service-role/AWS*",
      "arn:${var.partition}:iam::aws:policy/service-role/Amazon*",
      "arn:${var.partition}:iam::aws:policy/AWS*",
      "arn:${var.partition}:iam::aws:policy/Amazon*",
    ]
  }
  statement {
    // sid = "ListInstanceProfile"
    effect = "Allow"

    actions = [
      "iam:AddRoleToInstanceProfile",
      "iam:CreateInstanceProfile",
      "iam:DeleteInstanceProfile",
      "iam:GetInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
    ]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:instance-profile/${var.module_customer_namespace}-*",
    ]
  }
  statement {
    // sid = "RolePolicyNamespaceActions"
    effect = "Allow"

    actions = [
      "iam:AttachRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
    ]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}-*",
    ]

    condition {
      test     = "ArnLike"
      variable = "iam:PolicyArn"

      values = [
        "arn:${var.partition}:iam::${var.module_account_id}:policy/${var.module_customer_namespace}*",
        "arn:${var.partition}:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
        "arn:${var.partition}:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole",
        "arn:${var.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole",
        "arn:${var.partition}:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole",
        "arn:${var.partition}:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
        "arn:${var.partition}:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole",
        "arn:${var.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      ]
    }
  }
  statement {
    // sid = "RoleNamespaceActions"
    effect = "Allow"

    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRoleDescription",
      "iam:UpdateRole",
    ]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}-*",
    ]
  }
  statement {
    // sid = "RoleNamespaceActionsCustom"
    effect = "Allow"

    actions = [
      "iam:GetRolePolicy",
    ]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}-*",
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}",
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}BuildAgentRole",
    ]
  }
  statement {
    // sid = "PowerUserKMS"
    effect = "Allow"

    actions = [
      "kms:*",
    ]

    resources = ["*"]
  }
  statement {
    sid       = "AllowServiceUserAttaching"
    effect    = "Allow"
    actions   = ["iam:AttachUserPolicy"]
    resources = ["arn:${var.partition}:iam::${var.module_account_id}:user/s.${var.module_customer_namespace}*"]

    condition {
      test     = "ArnLike"
      variable = "iam:PolicyArn"
      values   = ["arn:${var.partition}:iam::${var.module_account_id}:policy/${var.module_customer_namespace}*"]
    }
  }
  statement {
    sid    = "AllowUsersToPerformServiceUserActions"
    effect = "Allow"

    actions = [
      "iam:CreateAccessKey",
      "iam:CreateUser",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:DeleteSigningCertificate",
      "iam:DeleteUser",
      "iam:DeleteUserPolicy",
      "iam:DetachUserPolicy",
      "iam:GetUser",
      "iam:GetUserPolicy",
      "iam:RemoveUserFromGroup",
      "iam:TagUser",
      "iam:UntagUser",
      "iam:UpdateUser",
    ]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:user/s.${var.module_customer_namespace}*",
    ]
  }

  // iam always policy end

  // s3 always policy start
  statement {
    //    sid         =   "AllowUserToSeeBucketListInTheConsole"
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:${var.partition}:s3:::*",
    ]
  }
  statement {
    //    sid         =   "TformRootAndConsumerList"
    effect    = "Allow"
    actions   = ["s3:List*"]
    resources = ["arn:${var.partition}:s3:::entsvcs-terraform*"]
  }
  statement {
    //    sid         =   "AllowAllS3ActionsInTFormStateFolder"
    effect  = "Allow"
    actions = ["s3:*"]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*/*",
      "arn:${var.partition}:s3:::entsvcs-terraform*/${var.module_customer_namespace}/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:PutBucketNotification",
      "s3:GetBucketNotification",
    ]
    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*/*",
    ]
  }
  statement {
    effect = "Deny"

    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
    ]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-${lower(var.module_prefix_option)}${lower(var.module_target_moniker)}-*",
      "arn:${var.partition}:s3:::entsvcs-terraform*/${var.module_customer_namespace}",
    ]
  }
  statement {
    //    sid         =   "DenyAllS3ActionsInTFormStateFolder"
    effect = "Deny"

    actions = [
      "s3:PutBucket*",
      "s3:PutLifecycle*",
      "s3:PutReplication*",
      "s3:PutAcceler*",
      "s3:DeleteBuck*",
    ]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-${lower(var.module_target_moniker)}-${var.module_target_region}/*",
      "arn:${var.partition}:s3:::entsvcs-terraform*/${var.module_customer_namespace}/*",
    ]
  }
  statement {
    //    sid         =   "AllowCopyAmiCrossAcctCrossRegion"
    effect = "Allow"

    actions = [
      "s3:CreateBucket",
      "s3:GetBucketAcl",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      "arn:${var.partition}:s3:::amis-for-*-in-*",
    ]
  }

  // AAA JWT Key Management SVCS
  // https://confluence.business.com/display/SECDEV/business+JWT+Reference+Guide

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

  // s3 always policy end

  statement {
    // sid      = "ThingsThatAreAllSplat"
    effect = "Allow"

    actions = [
      "autoscaling:*",
      "elasticloadbalancing:*",
      "tag:*",
      "events:*",
    ]

    resources = ["*"]
  }
  statement {
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
  statement {
    effect    = "Allow"
    actions   = ["sqs:ListQueues"]
    resources = ["arn:${var.partition}:sqs:*:*:*"]
  }

  /*** dynamodb inline section ***/

  /* This is a SHORTENED list - we are at policy max size */
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
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable",
      "dynamodb:UpdateTimeToLive",
      "dynamodb:UntagResource",
    ]

    resources = [
      "arn:${var.partition}:dynamodb:*:*:table/entsvcs-terraform*",
    ]
  }
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Query",
      "dynamodb:Scan",
    ]

    resources = [
      "arn:${var.partition}:dynamodb:*:*:table/entsvcs-terraform*",
      "arn:${var.partition}:dynamodb:*:*:table/entsvcs-terraform*/index/*",
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
      "arn:${var.partition}:dynamodb:*:*:table/entsvcs-terraform*",
    ]
  }

  // end dynamoDB

  // Cloudwatch logs
  statement {
    //    sid         = "CloudWatchLogs"
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

  // end cloudwatch logs

  // acm
  statement {
    // never add this to the acm.tf file.  it can then be attached to build
    //  users and be abused
    // sid = "AllowBuildAgentDeleteACMCerts"
    effect = "Allow"

    actions   = ["acm:DeleteCertificate"]
    resources = ["*"]
  }

  // end acm

  //aws support for clicky-clicky
  statement {
    effect = "Allow"

    actions = [
      "support:*",
      "sts:DecodeAuthorizationMessage",
    ]

    resources = ["*"]
  }

  statement {
    // sid = "AllowStsAssumeRoleInNamespace"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}-*",
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

