//elasticbeanstalk.tf
data "aws_iam_policy_document" "elasticbeanstalk_pd" {
  statement {
    sid    = "EBeanSAllowItems"
    effect = "Allow"

    actions = [
      "elasticbeanstalk:*",
      "acm:DescribeCertificate",
      "acm:ListCertificates",
      "codebuild:CreateProject",
      "codebuild:DeleteProject",
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "EBeanSContainS3Items"
    effect = "Allow"

    actions = [ "s3:*"]
    resources = [
      "arn:${var.partition}:s3:::elasticbeanstalk-*",
      "arn:${var.partition}:s3:::elasticbeanstalk-*/*"
    ]
  }

  statement {
    sid    = "EBeanSAllNonResourceCalls"
    effect = "Allow"

    actions = [
      "elasticbeanstalk:CheckDNSAvailability",
      "elasticbeanstalk:CreateStorageLocation",
    ]

    resources = ["*"]
  }

  statement {
    sid     = "EBeanSAllCallsOnSolutionStacks"
    effect  = "Allow"
    actions = ["elasticbeanstalk:*"]

    resources = [
      "arn:${var.partition}:elasticbeanstalk:*::solutionstack/*",
    ]
  }

  statement {
    sid    = "EBeanSAllCallsInApplications"
    effect = "Allow"

    actions = [
      "elasticbeanstalk:*",
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "elasticbeanstalk:InApplication"

      values = [
        "arn:${var.partition}:elasticbeanstalk:*:${var.module_account_id}:application/${var.module_customer_namespace}*",
      ]
    }
  }

  statement {
    sid    = "EBeanSAllCallsOnApplications"
    effect = "Allow"

    actions = [
      "elasticbeanstalk:*",
    ]

    resources = [
      "arn:${var.partition}:elasticbeanstalk:*:${var.module_account_id}:application/${var.module_customer_namespace}*",
    ]
  }

  statement {
    sid    = "EBeanSCFNResourceBasedPermissions"
    effect = "Allow"

    actions = [
      "cloudformation:CancelUpdateStack",
      "cloudformation:ContinueUpdateRollback",
      "cloudformation:Create*",
      "cloudformation:DeleteStack",
      "cloudformation:Describe*",
      "cloudformation:ExecuteChangeSet",
      "cloudformation:Get*",
      "cloudformation:List*",
      "cloudformation:SetStackPolicy",
      "cloudformation:SignalResource",
      "cloudformation:UpdateStack"
    ]

    resources = [
      "arn:${var.partition}:cloudformation:*:${var.module_account_id}:stack/awseb-*"
    ]

  }

  statement {
    sid    = "EBeanSAllowCustomerS3"
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
    ]

    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-${lower(var.module_target_moniker)}-${var.module_target_region}*",
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-${lower(var.module_target_moniker)}-${var.module_target_region}*/*",
    ]
  }

  statement {
    sid = "EBeanSRolePolicyNamespaceActions"
    effect = "Allow"

    actions = [ "iam:AttachRolePolicy" ]

    resources = [ "*" ]
    condition {
      test     = "StringLike"
      variable = "iam:PolicyArn"
      values = [
        "arn:${var.partition}:iam::aws:policy/AWSElasticBeanstalk*",
        "arn:${var.partition}:iam::aws:policy/service-role/AWSElasticBeanstalk*"
      ]
    }
  }

  statement {
    sid = "EBeanSListInstanceProfile"
    effect = "Allow"

    actions = [
      "iam:AddRoleToInstanceProfile",
      "iam:CreateInstanceProfile",
      "iam:DeleteInstanceProfile",
      "iam:GetInstanceProfile",
      "iam:PassRole",
      "iam:RemoveRoleFromInstanceProfile",
    ]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:role/aws-elasticbeanstalk*",
      "arn:${var.partition}:iam::${var.module_account_id}:instance-profile/aws-elasticbeanstalk*",
    ]
  }
}
