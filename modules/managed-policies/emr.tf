data "aws_iam_policy_document" "emr_pd" {
  /// May or may not need passrole permissions...
  /*
  statement {
    effect = "Allow"

    actions = [
      "iam:PassRole",
    ]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}-*",
    ]
  }
  */
  // EMR doesn't really allow for restricting resources, but can apparently restrict by tag on many items.
  // Reference on what can and can't have a condition: https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-access-iam.html#emr-fine-grained-cluster-access
  statement {
    sid       = "EMRConditionalActions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticmapreduce:DescribeCluster",
      "elasticmapreduce:DescribeStep",
      "elasticmapreduce:ListBootstrapActions",
      "elasticmapreduce:ListInstanceGroups",
      "elasticmapreduce:ListInstances",
      "elasticmapreduce:ListSteps",
      "elasticmapreduce:PutAutoScalingPolicy",
      "elasticmapreduce:RemoveAutoScalingPolicy",
      "elasticmapreduce:SetTerminationProtection ",
      "elasticmapreduce:TerminateJobFlows",
    ]

    condition {
      test     = "StringLike"
      variable = "elasticmapreduce:ResourceTag/Name"
      values   = ["${var.module_customer_namespace}-*"]
    }
  }

  //EMR actions that can't have conditions... 
  statement {
    sid       = "EMRNonConditionalActions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticmapreduce:AddInstanceGroups",
      "elasticmapreduce:AddJobFlowSteps",
      "elasticmapreduce:AddTags",
      "elasticmapreduce:CancelSteps",
      "elasticmapreduce:CreateSecurityConfiguration",
      "elasticmapreduce:DeleteSecurityConfiguration",
      "elasticmapreduce:DescribeSecurityConfiguration",
      "elasticmapreduce:ListClusters",
      "elasticmapreduce:ListSecurityConfigurations",
      "elasticmapreduce:ModifyInstanceGroups",
      "elasticmapreduce:RemoveTags",
      "elasticmapreduce:RunJobFlow",
      "elasticmapreduce:SetTerminationProtection",
      "elasticmapreduce:SetVisibleToAllUsers",
      "elasticmapreduce:TerminateJobFlows",
      "elasticmapreduce:ViewEventsFromAllClustersInConsole",
    ]
  }
}

