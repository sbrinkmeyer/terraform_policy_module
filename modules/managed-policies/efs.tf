//efs.tf
data "aws_iam_policy_document" "efs_pd" {
  statement {
    sid       = "efsSplatResource"
    effect    = "Allow"
    actions   = ["elasticfilesystem:Describe*"]
    resources = ["*"]
  }

  statement {
    sid       = "createEFS"
    effect    = "Allow"
    actions   = ["elasticfilesystem:CreateFileSystem"]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/Name"
      values   = ["${var.module_customer_namespace}-*"]
    }
  }
  statement {
    sid    = "efsWithNameTag"
    effect = "Allow"
    actions = [
      "elasticfilesystem:CreateMountTarget",
      "elasticfilesystem:CreateTags",
      "elasticfilesystem:DeleteFileSystem",
      "elasticfilesystem:DeleteMountTarget",
      "elasticfilesystem:DeleteTags",
      "elasticfilesystem:DescribeLifecycleConfiguration",
      "elasticfilesystem:DescribeMountTargetSecurityGroups",
      "elasticfilesystem:DescribeMountTargets",
      "elasticfilesystem:ModifyMountTargetSecurityGroups",
      "elasticfilesystem:PutLifecycleConfiguration",
      "elasticfilesystem:UpdateFileSystem",
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/Name"
      values   = ["${var.module_customer_namespace}-*"]
    }
  }

  // Deny messing with the EFS drives that we create for a tenant.
  statement {
    sid    = "DenyCatsEFSDrives"
    effect = "Deny"
    actions = [
      "elasticfilesystem:DeleteFileSystem",
      "elasticfilesystem:PutLifecycleConfiguration",
      "elasticfilesystem:UpdateFileSystem",
    ]
    resources = var.efs_arns
  }

  statement {
    sid    = "efsRequiredEC2NetworkStuff"
    effect = "Allow"

    actions = [
      "ec2:DescribeSubnets",
      "ec2:DescribeNetworkInterfaces",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
    ]

    resources = ["*"]
  }
}

