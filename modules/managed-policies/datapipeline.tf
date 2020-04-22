data "aws_iam_policy_document" "datapipeline_pd" {
  statement {
    actions   = ["datapipeline:*"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "datapipeline:Tag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

  statement {
    actions = [
      "datapipeline:GetAccountLimits",
      "datapipeline:PutAccountLimits",
      "datapipeline:ListPipelines",
      "datapipeline:DescribePipelines",
      "datapipeline:SetTaskStatus",
      "datapipeline:ReportTaskProgress",
      "datapipeline:ReportTaskRunnerHeartbeat",
      "datapipeline:CreatePipeline",
      "datapipeline:SetStatus",
      "datapipeline:PutPipelineDefinition",
      "datapipeline:PollForTask"
    ]
    resources = ["*"]
  }

   statement {
    sid     = "allowDataPipelineToPassAndGetRole"
    effect  = "Allow"
    actions = ["iam:PassRole", "iam:GetRole"]

    resources = [
      "arn:${var.partition}:iam::${var.module_account_id}:role/${var.module_customer_namespace}-*",
      "arn:${var.partition}:iam::*:role/DataPipelineDefaultResourceRole",
      "arn:${var.partition}:iam::*:role/DataPipelineDefaultRole",
    ]
  }
}

