//iam.tf
data "aws_iam_policy_document" "iam_pd" {
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
}

