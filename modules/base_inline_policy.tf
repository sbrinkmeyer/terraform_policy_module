//base_inline_policy.tf

data "aws_iam_policy_document" "base_pd" {
  statement {
    // sid = "EC2NonResourceBasedPermissions"
    effect = "Allow"

    actions = [
      "ec2:Copy*",
      "ec2:CreateImage",
      "ec2:CreateKeyPair",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:DeleteKeyPair",
      "ec2:DeleteSnapshot",
      "ec2:DeleteTags",
      "ec2:DeregisterImage",
      "ec2:Describe*",
      "ec2:GetConsoleOutput",
      "ec2:GetPasswordData",
      "ec2:ImportImage",
      "ec2:ImportInstance",
      "ec2:ImportKeyPair",
      "ec2:ImportSnapshot",
      "ec2:ImportVolume",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifyInstancePlacement",
      "ec2:ModifyNetworkInterface*",
      "ec2:ModifySnapshotAttribute",
      "ec2:ModifySubnetAttribute",
      "ec2:ModifyVolumeAttribute",
      "ec2:RegisterImage",
      "ec2:ReportInstanceStatus",
      "ec2:ResetImageAttribute",
      "ec2:ResetInstanceAttribute",
      "ec2:ResetNetworkInterfaceAttribute",
      "ec2:ResetSnapshotAttribute",
      "ec2:UnmonitorInstances",
    ]

    resources = ["*"]
  }

  statement {
    // sid =   "ec2GetConsoleScreenshot"
    effect  = "Allow"
    actions = ["ec2:GetConsoleOutput"]

    resources = [
      "arn:aws:ec2:*:${var.module_account_id}:instance/*",
    ]
  }

  statement {
    // sid         =   "EC2AllowInstanceActions"
    effect = "Allow"

    actions = [
      "ec2:AttachVolume",
      "ec2:DetachVolume",
      "ec2:RebootInstances",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
    ]

    resources = [
      "arn:aws:ec2:*:${var.module_account_id}:instance/*",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:InstanceProfile"
      values   = ["arn:aws:iam::${var.module_account_id}:instance-profile/${var.module_tenant_namespace}*"]
    }
  }

  statement {
    // sid         =   "EC2AllowVolumeActions"
    effect = "Allow"

    actions = [
      "ec2:AttachVolume",
      "ec2:DeleteVolume",
      "ec2:DetachVolume",
    ]

    resources = [
      "arn:aws:ec2:*:${var.module_account_id}:volume/*",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/Name"
      values   = ["${var.module_tenant_namespace}*"]
    }
  }

  statement {
    // sid =   "EC2RunInstances"
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:${var.module_account_id}:instance/*"]

    actions = [
      "ec2:RunInstances",
      "ec2:AssociateIamInstanceProfile",
      "ec2:ReplaceIamInstanceProfileAssociation",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:InstanceProfile"

      values = [
        "arn:aws:iam::${var.module_account_id}:instance-profile/${var.module_tenant_namespace}-*",
      ]
    }
  }

  statement {
    // sid =   "EC2RunInstancesSubnet"
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:${var.module_account_id}:subnet/*"]

    actions = [
      "ec2:RunInstances",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:vpc"

      values = [
        "arn:aws:ec2:*:${var.module_account_id}:vpc/vpc-*",
      ]

      //      TODO: figure out an array fo vpcs for account
      //        "arn:aws:ec2:*:${var.module_account_id}:vpc/${var.module_target_vpc}"
    }
  }

  statement {
    // sid = "CRUDEC2Volumes"
    effect    = "Allow"
    actions   = ["ec2:CreateVolume"]
    resources = ["*"]

    // https://github.com/terraform-providers/terraform-provider-aws/issues/1533
    // condition {
    //   test = "StringLike"
    //   variable = "aws:RequestTag/Name"
    //   values = ["${var.module_tenant_namespace}*"]
    // }
    condition {
      test     = "NumericLessThanEquals"
      variable = "ec2:VolumeSize"
      values   = ["100"]
    }

    condition {
      test     = "Bool"
      variable = "ec2:Encrypted"
      values   = ["true"]
    }
  }

  statement {
    // sid =   "EC2RemainingRunInstancePermissions"
    actions = [
      "ec2:RunInstances",
    ]

    resources = [
      "arn:aws:ec2:*:${var.module_account_id}:volume/*",
      "arn:aws:ec2:*::image/*",
      "arn:aws:ec2:*::snapshot/*",
      "arn:aws:ec2:*:${var.module_account_id}:network-interface/*",
      "arn:aws:ec2:*:${var.module_account_id}:key-pair/*",
      "arn:aws:ec2:*:${var.module_account_id}:security-group/*",
    ]

    effect = "Allow"
  }

  statement {
    // sid      = "EC2VpcNonresourceSpecificActions"
    effect = "Allow"

    actions = [
      "ec2:AuthorizeSecurityGroup*",
      "ec2:RevokeSecurityGroup*",
      "ec2:DeleteSecurityGroup",
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "ec2:vpc"

      values = [
        "arn:aws:ec2:*:${var.module_account_id}:vpc/vpc-*",
      ]

      //      TODO: figure out an array fo vpcs for account
      //                        "arn:aws:ec2:*:${var.module_account_id}:vpc/${var.module_target_vpc}"
    }
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
      "iam:List*",
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
      "iam:GetRole",
    ]

    resources = [
      "arn:aws:iam::${var.module_account_id}:role/${var.module_tenant_namespace}-*",
      "arn:aws:iam::*:role/lambda_basic_execution",
    ]
  }
  statement {
    // sid = "IAMServerCertSplatPermissions"
    effect = "Allow"

    actions = [
      "iam:DescribeCertificate",
    ]

    //covered with a splat at the top
    // "iam:ListCertificate",
    // "iam:ListTagsForCertificate"

    resources = ["*"]
  }
  statement {
    // sid = "IAMServerCertificatePermissions"
    effect = "Allow"

    actions = [
      "iam:UploadServerCertificate",
      "iam:DeleteServerCertificate",
      "iam:ListServerCertificates",
      "iam:UpdateServerCertificate",
      "iam:GetServerCertificate",
    ]

    resources = ["arn:aws:iam::${var.module_account_id}:server-certificate/${var.module_tenant_namespace}-*"]
  }
  statement {
    // sid = "AllowedNSPolicies"
    effect = "Allow"

    actions = [
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListEntitiesForPolicy",
      "iam:ListPolicyVersions",
    ]

    resources = [
      "arn:aws:iam::${var.module_account_id}:policy/${var.module_tenant_namespace}-*",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
      "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole",
      "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole",
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
      "arn:aws:iam::${var.module_account_id}:instance-profile/${var.module_tenant_namespace}-*",
    ]
  }
  statement {
    // sid = "RolePolicyNamespaceActions"
    effect = "Allow"

    actions = [
      "iam:AttachRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
    ]

    resources = [
      "arn:aws:iam::${var.module_account_id}:role/${var.module_tenant_namespace}-*",
    ]

    condition {
      test     = "ArnLike"
      variable = "iam:PolicyArn"

      values = [
        "arn:aws:iam::${var.module_account_id}:policy/${var.module_tenant_namespace}*",
        "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
        "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole",
        "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole",
      ]
    }
  }
  statement {
    // sid = "RoleNamespaceActions"
    effect = "Allow"

    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:ListRolePolicies",
      "iam:UpdateAssumeRolePolicy",
    ]

    resources = [
      "arn:aws:iam::${var.module_account_id}:role/${var.module_tenant_namespace}-*",
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
    resources = ["arn:aws:iam::${var.module_account_id}:user/s.${var.module_tenant_namespace}*"]

    condition {
      test     = "ArnLike"
      variable = "iam:PolicyArn"
      values   = ["arn:aws:iam::${var.module_account_id}:policy/${var.module_tenant_namespace}*"]
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
      "iam:ListAttachedUserPolicies",
      "iam:ListGroupsForUser",
      "iam:ListUserPolicies",
      "iam:ListUsers",
      "iam:RemoveUserFromGroup",
      "iam:UpdateUser",
    ]

    resources = [
      "arn:aws:iam::${var.module_account_id}:user/s.${var.module_tenant_namespace}*",
    ]
  }
  statement {
    sid    = "AllowUsersToSeeStatsOnIAMConsoleDashboard"
    effect = "Allow"

    actions = [
      "iam:GetAccount*",
      "iam:ListAccount*",
    ]

    resources = ["*"]
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
      "arn:aws:s3:::*",
    ]
  }
  statement {
    //    sid         =   "TformRootAndConsumerList"
    effect  = "Allow"
    actions = ["s3:ListBucket"]

    resources = [
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-*",
      "arn:aws:s3:::entsvcs-terraform*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:prefix"
      values   = ["", "${var.module_tenant_namespace}/"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:delimiter"
      values   = ["/"]
    }
  }
  statement {
    //    sid         =   "ListTFormStateFolder"
    effect  = "Allow"
    actions = ["s3:ListBucket"]

    resources = [
      "arn:aws:s3:::entsvcs-terraform*",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values   = ["${var.module_tenant_namespace}/*"]
    }
  }
  statement {
    //    sid         =   "AllowAllS3ActionsInTFormStateFolder"
    effect  = "Allow"
    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-*",
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-*/*",
      "arn:aws:s3:::entsvcs-terraform*/${var.module_tenant_namespace}/*",
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
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-${lower(var.module_target_moniker)}-${var.module_target_region}/*",
      "arn:aws:s3:::entsvcs-terraform*/${var.module_tenant_namespace}/*",
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
      "arn:aws:s3:::amis-for-*-in-*",
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
      "ses:*",
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
    resources = ["arn:aws:sqs:*:*:*"]
  }
  /*** dynamodb inline section ***/
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
    ]

    // resources = [ "arn:aws:logs:*:*:${var.module_tenant_namespace}*" ]
    resources = ["*"]
  }
}
