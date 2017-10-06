//elasticbeanstalk.tf
data "aws_iam_policy_document" "elasticbeanstalk_pd" {
  statement {
    sid    = "AllowEBSItems"
    effect = "Allow"

    actions = [
      "elasticbeanstalk:*",
      "acm:DescribeCertificate",
      "acm:ListCertificates",
      "codebuild:CreateProject",
      "codebuild:DeleteProject",
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllNonResourceCalls"
    effect = "Allow"

    actions = [
      "elasticbeanstalk:CheckDNSAvailability",
      "elasticbeanstalk:CreateStorageLocation",
    ]

    resources = ["*"]
  }

  statement {
    sid     = "AllCallsOnSolutionStacks"
    effect  = "Allow"
    actions = ["elasticbeanstalk:*"]

    resources = [
      "arn:aws:elasticbeanstalk:*::solutionstack/*",
    ]
  }

  statement {
    sid    = "AllCallsInApplications"
    effect = "Allow"

    actions = [
      "elasticbeanstalk:*",
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "elasticbeanstalk:InApplication"

      values = [
        "arn:aws:elasticbeanstalk:*:${var.module_account_id}:application/${var.module_tenant_namespace}*",
      ]
    }
  }

  statement {
    sid    = "AllCallsOnApplications"
    effect = "Allow"

    actions = [
      "elasticbeanstalk:*",
    ]

    resources = [
      "arn:aws:elasticbeanstalk:*:${var.module_account_id}:application/${var.module_tenant_namespace}*",
    ]
  }

  statement {
    sid    = "AllowtenantBeanstalkS3"
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
    ]

    resources = [
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-${lower(var.module_target_moniker)}-${var.module_target_region}*",
      "arn:aws:s3:::${lower(var.module_tenant_namespace)}-${lower(var.module_target_moniker)}-${var.module_target_region}*/*",
    ]
  }
}
