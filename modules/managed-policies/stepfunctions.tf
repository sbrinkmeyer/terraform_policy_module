//stepfunctions.tf

data "aws_iam_policy_document" "stepfunctions_pd" {
  statement {
    sid    = "StepFunctionsSplatPermissions"
    effect = "Allow"

    actions = [
      "states:SendTaskSuccess",
      "states:ListStateMachines",
      "states:SendTaskFailure",
      "states:ListActivities",
      "states:ListTagsForResource",
      "states:CreateActivity",
      "states:StopExecution",
      "states:SendTaskHeartbeat",
      "states:CreateStateMachine",
      "states:TagResource",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "StepFunctionsResourceBasedPermissions"
    effect = "Allow"

    actions = [
      "states:DescribeStateMachineForExecution",
      "states:DescribeActivity",
      "states:DescribeStateMachine",
      "states:DescribeExecution",
      "states:ListExecutions",
      "states:GetExecutionHistory",
      "states:UpdateStateMachine",
      "states:DeleteStateMachine",
      "states:StartExecution",
      "states:DeleteActivity",
      "states:GetActivityTask",
      "states:TagResource",
      "states:UntagResource",
    ]

    resources = [
      "arn:${var.partition}:states:*:${var.module_account_id}:stateMachine:${var.module_customer_namespace}-*",
      "arn:${var.partition}:states:*:${var.module_account_id}:activity:${var.module_customer_namespace}-*",
      "arn:${var.partition}:states:*:${var.module_account_id}:execution:${var.module_customer_namespace}-*",
    ]
  }
}

