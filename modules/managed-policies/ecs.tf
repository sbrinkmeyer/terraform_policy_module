//ecs.tf

data "aws_iam_policy_document" "ecs_pd" {
  statement {
    sid       = "ecsSplatResources"
    effect    = "Allow"
    actions   = [
      "ecs:List*",
      "ecs:Describe*",
      "ecs:CreateCluster",
      "ecs:RegisterTaskDefinition",
      "ecs:DeregisterTaskDefinition",
      "ecs:CreateTaskSet",
    ]
    resources = [
      "*"
    ]
  }

statement {
    sid       = "ecsTagResource"
    effect    = "Allow"
    actions   = [ "ecs:TagResource" ]
    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/Name"
      values   = ["${var.module_customer_namespace}-*"]
    }
    resources = [ "*" ]
  }

statement {
    sid       = "ecsUnTagResource"
    effect    = "Allow"
    actions   = [ "ecs:TagResource","ecs:UntagResource" ]
    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/Name"
      values   = ["${var.module_customer_namespace}-*"]
    }
    resources = [ "*" ]
  }

  statement {
    sid       = "ecsNameSpaceActions"
    effect    = "Allow"
    actions   = [
      "ecs:*"
    ]
    resources = [
      "arn:${var.partition}:ecs:*:${var.module_account_id}:cluster/${var.module_customer_namespace}*",
      "arn:${var.partition}:ecs:*:${var.module_account_id}:container-instance/*",
      "arn:${var.partition}:ecs:*:${var.module_account_id}:service/${var.module_customer_namespace}*",
      "arn:${var.partition}:ecs:*:${var.module_account_id}:task/${var.module_customer_namespace}*",
      "arn:${var.partition}:ecs:*:${var.module_account_id}:task-definition/${var.module_customer_namespace}*:*",
      "arn:${var.partition}:ecs:*:${var.module_account_id}:task-definition/${var.module_customer_namespace}*",
      "arn:${var.partition}:ecs:*:${var.module_account_id}:task-set/${var.module_customer_namespace}*/${var.module_customer_namespace}*/*"
    ]
  }

  statement {
    sid = "ecrNameSpaceActions"

    resources = [
      "arn:${var.partition}:ecr:*:${var.module_account_id}:repository/${lower(var.module_customer_namespace)}*",
    ]

    effect = "Allow"

    actions = [
      "ecr:Batch*",
      "ecr:CompleteLayerUpload",
      "ecr:DeleteLifecyclePolicy",
      "ecr:DeleteRepository",
      "ecr:DeleteRepositoryPolicy",
      "ecr:Describe*",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      "ecr:ListTagsForResource",
      "ecr:PutImage",
      "ecr:PutLifecyclePolicy",
      "ecr:SetRepositoryPolicy",
      "ecr:StartLifecyclePolicyPreview",
      "ecr:UploadLayerPart",
      "ecr:TagResource",
      "ecr:UntagResource",
    ]
  }

  statement {
    sid       = "ecrSplatActions"
    resources = ["*"]
    effect    = "Allow"
    actions   = ["ecr:CreateRepository", "ecr:Get*", "ecr:DescribeRepositories"]
  }

  statement {
    sid       = "EC2VpcNonresourceSpecificActions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
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
    sid       = "EC2NonResourceBasedPermissions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:Describe*",
      "ec2:CreateImage",
      "ec2:CreateKeyPair",
      "ec2:CreateTags",
      "ec2:CreateSecurityGroup",
      "ec2:DeleteTags",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifyNetworkInterfaceAttribute",
    ]
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
    effect    = "Allow"
    actions   = ["elasticloadbalancing:Describe*"]
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
}

