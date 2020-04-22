//redshift.tf
data "aws_iam_policy_document" "redshift_pd" {
  statement {
    effect = "Allow"
    actions = [
      "redshift:DescribeClusters",
      "redshift:DescribeClusterParameterGroups",
      "redshift:DescribeClusterSecurityGroups",
      "redshift:DescribeClusterSnapshots",
      "redshift:DescribeClusterSubnetGroups",
      "redshift:DescribeClusterVersions",
      "redshift:DescribeDefaultClusterParameters",
      "redshift:DescribeEventCategories",
      "redshift:DescribeEvents",
      "redshift:DescribeEventSubscriptions",
      "redshift:DescribeHsmClientCertificates",
      "redshift:DescribeHsmConfigurations",
      "redshift:DescribeLoggingStatus",
      "redshift:DescribeOrderableClusterOptions",
      "redshift:DescribeReservedNodeOfferings",
      "redshift:DescribeReservedNodes",
      "redshift:DescribeResize",
      "redshift:DescribeSnapshotCopyGrants",
      "redshift:DescribeTableRestoreStatus",
      "redshift:DescribeTags",
    ]
    resources = ["*"]
  }

  statement {
    effect  = "Allow"
    actions = ["redshift:*"]
    resources = [
      "arn:${var.partition}:redshift:*:*:cluster:${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:redshift:*:*:snapshot:${lower(var.module_customer_namespace)}-*/*",
      "arn:${var.partition}:redshift:*:*:parametergroup:${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:redshift:*:*:eventsubscription:${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:redshift:*:*:hsmclientcertificate:${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:redshift:*:*:hsmconfiguration:${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:redshift:*:*:snapshotcopygrant:${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:redshift:*:*:securitygroup:${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:redshift:*:*:subnetgroup:${lower(var.module_customer_namespace)}-*",
    ]
  }

  // Allow creation of the Redshift service linked role.
  statement {
    effect    = "Allow"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["arn:${var.partition}:iam::*:role/aws-service-role/redshift.amazonaws.com/AWSServiceRoleForRedshift"]
  }
}

