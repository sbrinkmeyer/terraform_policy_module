//ecs.tf

data "aws_iam_policy_document" "ecs_pd" {
  statement {
    sid       = "ecsSplatResources"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["ecs:*"]
  }

  statement {
    sid = "ecrNameSpaceActions"

    resources = [
      "arn:aws:ecr:*:${var.module_account_id}:repository/${lower(var.module_tenant_namespace)}*",
    ]

    effect = "Allow"

    actions = [
      "ecr:Batch*",
      "ecr:CompleteLayerUpload",
      "ecr:Describe*",
      "ecr:DeleteRepository",
      "ecr:DeleteRepositoryPolicy",
      "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      "ecr:PutImage",
      "ecr:SetRepositoryPolicy",
      "ecr:UploadLayerPart",
    ]
  }

  statement {
    sid       = "ecrSplatActions"
    resources = ["*"]
    effect    = "Allow"
    actions   = ["ecr:CreateRepository", "ecr:Get*"]
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
        "arn:aws:ec2:*:${var.module_account_id}:vpc/vpc-*",
      ]

      //      TODO: figure out an array fo vpcs for account
      //          "arn:aws:ec2:*:${var.module_account_id}:vpc/${var.module_target_vpc}"
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
