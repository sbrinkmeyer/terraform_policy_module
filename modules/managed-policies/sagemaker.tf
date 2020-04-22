//sagemaker.tf
data "aws_iam_policy_document" "sagemaker_pd" {
  //Allow read-only actions on all resources
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:Describe*",
      "sagemaker:GetSearchSuggestions",
      "sagemaker:List*",
      "sagemaker:Search",
    ]
    resources = ["*"]
  }

  //Allow all actions on resouces in the namespace
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:*",
    ]
    resources = [
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:*/*",
    ]
    condition {
      test     = "StringLike"
      variable = "sagemaker:ResourceTag/Name"
      values   = ["${var.module_customer_namespace}-*"]
    }
  }

  //Allow actions on notebook-instance
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateNotebookInstance",
      "sagemaker:StartNotebookInstance",
      "sagemaker:StopNotebookInstance",
      "sagemaker:UpdateNotebookInstance",
      "sagemaker:DeleteNotebookInstance",
      "sagemaker:CreatePresignedNotebookInstanceUrl",
      "sagemaker:DescribeNotebookInstance",
    ]
    resources = ["arn:${var.partition}:sagemaker:*:${var.module_account_id}:notebook-instance/${var.module_customer_namespace}-*"]
  }

  //Allow tagging actions on all resources
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:AddTags",
      "sagemaker:DeleteTags",
    ]
    resources = [
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:endpoint/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:endpoint-config/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:hyper-parameter-tuning-job/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:labeling-job/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:model/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:notebook-instance/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:training-job/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:transform-job/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:workteam/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:compilation-job/${var.module_customer_namespace}-*",
    ]
  }

  //Allow actions on enpoint-config
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateEndpointConfig",
      "sagemaker:DeleteEndpointConfig",
      "sagemaker:DescribeEndpointConfig",
    ]
    resources = ["arn:${var.partition}:sagemaker:*:${var.module_account_id}:endpoint-config/${var.module_customer_namespace}-*"]
  }

  //Allow actions on endpoint
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateEndpoint",
      "sagemaker:DeleteEndpoint",
      "sagemaker:DescribeEndpoint",
      "sagemaker:InvokeEndpoint",
      "sagemaker:UpdateEndpoint",
      "sagemaker:UpdateEndpointWeightsAndCapacities",
    ]
    resources = ["arn:${var.partition}:sagemaker:*:${var.module_account_id}:endpoint/${var.module_customer_namespace}-*"]
  }

  //Allow actions on hyper-parameter-tuning-job
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateHyperParameterTuningJob",
      "sagemaker:DescribeHyperParameterTuningJob",
      "sagemaker:ListHyperParameterTuningJobs",
      "sagemaker:ListTrainingJobsForHyperParameterTuningJob",
      "sagemaker:StopHyperParameterTuningJob",
    ]
    resources = ["arn:${var.partition}:sagemaker:*:${var.module_account_id}:hyper-parameter-tuning-job/${var.module_customer_namespace}-*"]
  }

  //Allow actions on labeling-job
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateLabelingJob",
      "sagemaker:DescribeLabelingJob",
      "sagemaker:StopLabelingJob",
    ]
    resources = ["arn:${var.partition}:sagemaker:*:${var.module_account_id}:labeling-job/${var.module_customer_namespace}-*"]
  }

  //Allow actions on model
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateModel",
      "sagemaker:DeleteModel",
      "sagemaker:DescribeModel",
    ]
    resources = ["arn:${var.partition}:sagemaker:*:${var.module_account_id}:model/${var.module_customer_namespace}-*"]
  }

  //Allow actions on training-job
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateTrainingJob",
      "sagemaker:DescribeTrainingJob",
      "sagemaker:StopTrainingJob",
    ]
    resources = ["arn:${var.partition}:sagemaker:*:${var.module_account_id}:training-job/${var.module_customer_namespace}-*"]
  }

  //Allow actions on transform-job
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateTransformJob",
      "sagemaker:DescribeTransformJob",
      "sagemaker:StopTransformJob",
    ]
    resources = ["arn:${var.partition}:sagemaker:*:${var.module_account_id}:transform-job/${var.module_customer_namespace}-*"]
  }

  //Allow actions on compilation-job
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateCompilationJob",
      "sagemaker:DescribeCompilationJob",
      "sagemaker:StopCompilationJob",
    ]
    resources = ["arn:${var.partition}:sagemaker:*:${var.module_account_id}:compilation-job/${var.module_customer_namespace}-*"]
  }

  //Allow actions on workteam
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:CreateWorkteam",
      "sagemaker:DeleteWorkteam",
      "sagemaker:DescribeSubscribedWorkteam",
      "sagemaker:DescribeWorkteam",
      "sagemaker:UpdateWorkteam",
    ]
    resources = [
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:workteam/private-crowd/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:workteam/public-crowd/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:workteam/vendor-crowd/${var.module_customer_namespace}-*",
      "arn:${var.partition}:sagemaker:*:${var.module_account_id}:workteam/${var.module_customer_namespace}-*",
    ]
  }
}

