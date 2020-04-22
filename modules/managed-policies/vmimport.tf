data "aws_iam_policy_document" "vmimport_pd" {
  // Minimal permissions for vmimport.  Currently s3.tf, ec2.tf and/or base_inline_policy.tf cover all the needed permissions.
  // Unless ec2:ImportImage is removed from ec2.tf, this policy is uneeded.
  statement {
    sid    = "Grantminimalpermissions"
    effect = "Allow"
    actions = [
      "ec2:CopySnapshot",
      "ec2:Describe*",
      "ec2:ImportImage",
      "ec2:ImportInstance",
      "ec2:ImportSnapshot",
      "ec2:ImportVolume",
      "ec2:ModifySnapshotAttribute",
      "ec2:RegisterImage",
    ]
    resources = [
      "*",
    ]
  }
}

