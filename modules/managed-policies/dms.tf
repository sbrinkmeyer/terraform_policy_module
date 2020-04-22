//dms.tf
data "aws_iam_policy_document" "dms_pd" {

//resource tag condition
statement {
    sid    = "AllowDMSResourceTag"
    effect = "Allow"

    actions = [
      "dms:AddTagsToResource",
      "dms:ApplyPendingMaintenanceAction",
      "dms:CreateReplicationTask",
      "dms:DeleteCertificate",
      "dms:DeleteEndpoint",
      "dms:DeleteEventSubscription",
      "dms:DeleteReplicationInstance",
      "dms:DeleteReplicationSubnetGroup",
      "dms:DeleteReplicationTask",
      "dms:DescribeRefreshSchemasStatus",
      "dms:DescribeReplicationInstanceTaskLogs",
      "dms:DescribeReplicationTaskAssessmentResults",
      "dms:DescribeSchemas",
      "dms:DescribeTableStatistics",
      "dms:ListTagsForResource",
      "dms:ModifyEndpoint",
      "dms:ModifyReplicationInstance",
      "dms:ModifyReplicationTask",
      "dms:RebootReplicationInstance",
      "dms:RefreshSchemas",
      "dms:ReloadTables",
      "dms:RemoveTagsFromResource",
      "dms:StartReplicationTask",
      "dms:StartReplicationTaskAssessment",
      "dms:StopReplicationTask",
      "dms:TestConnection",
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

//request tag condition
statement {
    sid    = "AllowDMSRequestTag"
    effect = "Allow"

    actions = [
      "dms:Create*",
      "dms:AddTagsToResource",
      "dms:ImportCertificate",
    ]

    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

// anonymous
  statement {
    sid    = "AllowDMSAllResources"
    effect = "Allow"
    actions = [
      "dms:DescribeAccountAttributes",
      "dms:DescribeCertificates",
      "dms:DescribeConnections",
      "dms:DescribeEndpointTypes",
      "dms:DescribeEndpoints",
      "dms:DescribeEventCategories",
      "dms:DescribeEventSubscriptions",
      "dms:DescribeEvents",
      "dms:DescribeOrderableReplicationInstances",
      "dms:DescribeReplicationInstances",
      "dms:DescribeReplicationSubnetGroups",
      "dms:DescribeReplicationTasks",
      "dms:ModifyEventSubscription ",
      "dms:ModifyReplicationSubnetGroup",
    ]
    resources = ["*"]
  }
}
