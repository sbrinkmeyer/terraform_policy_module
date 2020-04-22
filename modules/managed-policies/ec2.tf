//ec2.tf
data "aws_iam_policy_document" "ec2_pd" {
  statement {
    sid    = "EC2NonResourceBasedPermissions"
    effect = "Allow"

    actions = [
      "ec2:AttachNetworkInterface",
      "ec2:Copy*",
      "ec2:CreateImage",
      "ec2:CreateKeyPair",
      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:DeleteKeyPair",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteNetworkInterfacePermission",
      "ec2:DeleteSnapshot",
      "ec2:DeleteTags",
      "ec2:DeregisterImage",
      "ec2:Describe*",
      "ec2:DetachNetworkInterface",
      "ec2:GetConsoleOutput",
      "ec2:GetConsoleScreenshot",
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
      "ec2:ModifyVolume",
      "ec2:ModifyVolumeAttribute",
      "ec2:MonitorInstances",
      "ec2:RegisterImage",
      "ec2:ReportInstanceStatus",
      "ec2:ResetImageAttribute",
      "ec2:ResetInstanceAttribute",
      "ec2:ResetNetworkInterfaceAttribute",
      "ec2:ResetSnapshotAttribute",
      "ec2:UnmonitorInstances",
      "ec2:CreateLaunchTemplate",
      "ec2:DescribeLaunchTemplate",
      "ec2:DescribeLaunchTemplates",
      "ec2:GetLaunchTemplateData",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "ec2LaunchTemplates"
    effect = "Allow"
    actions = [
      "ec2:CreateLaunchTemplateVersion",
      "ec2:DeleteLaunchTemplate",
      "ec2:DeleteLaunchTemplateVersions",
      "ec2:ModifyLaunchTemplate",
    ]
    resources = [
      "arn:${var.partition}:ec2:*:${var.module_account_id}:launch-template/*",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

  statement {
    sid     = "ec2GetConsoleScreenshot"
    effect  = "Allow"
    actions = ["ec2:GetConsoleScreenshot"]

    resources = [
      "arn:${var.partition}:ec2:*:${var.module_account_id}:instance/*",
    ]
  }

  statement {
    sid    = "EC2AllowInstanceActions"
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
      "arn:${var.partition}:ec2:*:${var.module_account_id}:instance/*",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:InstanceProfile"
      values   = ["arn:${var.partition}:iam::${var.module_account_id}:instance-profile/${var.module_customer_namespace}*"]
    }
  }

  statement {
    sid    = "EC2AllowVolumeActions"
    effect = "Allow"

    actions = [
      "ec2:AttachVolume",
      "ec2:DeleteVolume",
      "ec2:DetachVolume",
    ]

    resources = [
      "arn:${var.partition}:ec2:*:${var.module_account_id}:volume/*",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

  statement {
    sid       = "EC2RunInstances"
    effect    = "Allow"
    resources = ["arn:${var.partition}:ec2:*:${var.module_account_id}:instance/*"]

    actions = [
      "ec2:RunInstances",
      "ec2:AssociateIamInstanceProfile",
      "ec2:ReplaceIamInstanceProfileAssociation",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:InstanceProfile"

      values = [
        "arn:${var.partition}:iam::${var.module_account_id}:instance-profile/${var.module_customer_namespace}-*",
      ]
    }
  }

  statement {
    sid       = "EC2RunInstancesSubnet"
    effect    = "Allow"
    resources = ["arn:${var.partition}:ec2:*:${var.module_account_id}:subnet/*"]

    actions = [
      "ec2:RunInstances",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:vpc"

      values = [
        "arn:${var.partition}:ec2:*:${var.module_account_id}:vpc/vpc-*",
      ]
      //      TODO: figure out an array fo vpcs for account
      //          "arn:${var.partition}:ec2:*:${var.module_account_id}:vpc/${var.module_target_vpc}"
    }
  }

  statement {
    sid       = "CRUDEC2Volumes"
    effect    = "Allow"
    actions   = ["ec2:CreateVolume"]
    resources = ["*"]

    condition {
      test     = "Bool"
      variable = "ec2:Encrypted"
      values   = ["true"]
    }
  }

  statement {
    sid       = "CNCRUDEC2Volumes"
    effect    = "Allow"
    actions   = ["ec2:CreateVolume"]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["cn-north-1"]
    }
  }

  statement {
    sid = "EC2RemainingRunInstancePermissions"

    actions = [
      "ec2:RunInstances",
    ]

    resources = [
      "arn:${var.partition}:ec2:*:${var.module_account_id}:volume/*",
      "arn:${var.partition}:ec2:*::image/*",
      "arn:${var.partition}:ec2:*::snapshot/*",
      "arn:${var.partition}:ec2:*:${var.module_account_id}:network-interface/*",
      "arn:${var.partition}:ec2:*:${var.module_account_id}:key-pair/*",
      "arn:${var.partition}:ec2:*:${var.module_account_id}:security-group/*",
    ]

    effect = "Allow"
  }

  statement {
    sid       = "EC2VpcNonresourceSpecificActions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AuthorizeSecurityGroup*",
      "ec2:RevokeSecurityGroup*",
      "ec2:DeleteSecurityGroup",
      "ec2:UpdateSecurityGroup*",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }

    condition {
      test     = "StringLike"
      variable = "ec2:vpc"

      values = [
        "arn:${var.partition}:ec2:*:${var.module_account_id}:vpc/vpc-*",
      ]
      //      TODO: figure out an array fo vpcs for account
      //          "arn:${var.partition}:ec2:*:${var.module_account_id}:vpc/${var.module_target_vpc}"
    }
  }

  statement {
    // sid      = "EC2UpdateSecurityGroup"
    effect = "Allow"

    actions = [
      "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
      "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

  statement {
    // sid = "AutoscalingNonResourceBasedPermissions"
    effect = "Allow"

    actions = [
      "autoscaling:*",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:*",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "dlm:*",
    ]

    resources = ["*"]
  }
  // If DLM ends up moving to proper names we can use the code below
  /*
  statement {
    effect = "Allow"

    actions = [
      "dlm:GetLifecyclePolicies",
      "dlm:GetLifecyclePolicy",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "dlm:CreateLifecyclePolicy",
      "dlm:DeleteLifecyclePolicy",
      "dlm:UpdateLifecyclePolicy",
    ]

    resources = ["arn:${var.partition}:dlm:*:${var.module_account_id}:policy/${var.module_customer_namespace}-*"]
  }
  */
}

