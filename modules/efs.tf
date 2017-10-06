//efs.tf
data "aws_iam_policy_document" "efs_pd" {
  statement {
    sid       = "efsSplatResource"
    effect    = "Allow"
    actions   = ["elasticfilesystem:Describe*"]
    resources = ["*"]
  }

  statement {
    sid    = "efsWithFileSystemID"
    effect = "Allow"

    actions = [
      "elasticfilesystem:CreateMountTarget",
      "elasticfilesystem:CreateTags",
      "elasticfilesystem:DeleteMountTarget",
      "elasticfilesystem:DeleteTags",
      "elasticfilesystem:ModifyMountTargetSecurityGroups",
    ]

    resources = [
      "arn:aws:elasticfilesystem:*:${var.module_account_id}:file-system/${var.module_target_efs_fsid}",
    ]
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
