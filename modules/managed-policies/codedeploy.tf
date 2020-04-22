//codedeploy.tf
data "aws_iam_policy_document" "codedeploy_pd" {
  statement {
    actions = [
      "codedeploy:Batch*",
      "codedeploy:Get*",
      "codedeploy:AddTagsToOnPremisesInstances",
      "codedeploy:DeregisterOnPremisesInstance",
      "codedeploy:RegisterOnPremisesInstance",
      "codedeploy:RemoveTagsFromOnPremisesInstances",
      "codedeploy:Create*",
      "codedeploy:Delete*",
      "codedeploy:List*",
      "codedeploy:RegisterApplicationRevision",
      "codedeploy:UpdateApplication",
      "codedeploy:UpdateDeploymentGroup",
      "ec2:TerminateInstances",
      "lambda:GetAlias",
      "lambda:UpdateAlias",
      "lambda:InvokeFunction",
      "lambda:UntagResource",
      "lambda:UntagResources*",
      "sns:Publish", // from our sns policy
      "s3:*", // from our s3 policy
    ]
    resources = [
      "arn:${var.partition}:codedeploy:*:${var.module_account_id}:instance/*",
      "arn:${var.partition}:codedeploy:*:${var.module_account_id}:application/${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:codedeploy:*:${var.module_account_id}:deploymentgroup/${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:codedeploy:*:${var.module_account_id}:deploymentconfig/${lower(var.module_customer_namespace)}-*",
      "arn:${var.partition}:ec2:*:${var.module_account_id}:instance/*",
      "arn:${var.partition}:lambda:*:*:function:${var.module_customer_namespace}-*",
      "arn:${var.partition}:lambda:*:*:function:CodeDeployHook_${var.module_customer_namespace}-*",
      "arn:${var.partition}:sns:*:${var.module_account_id}:${lower(var.module_customer_namespace)}-*", // from our sns policy
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*", // from our s3 policy
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-*/*", // from our s3 policy
      "arn:${var.partition}:s3:::entsvcs-terraform*/${var.module_customer_namespace}/*", // from our s3 policy
     ]
  }
  
  // This block overrides the s3:* above
  statement {
    effect = "Deny"
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
    ]
    resources = [
      "arn:${var.partition}:s3:::${lower(var.module_customer_namespace)}-${lower(var.module_prefix_option)}${lower(var.module_target_moniker)}-*",
      "arn:${var.partition}:s3:::entsvcs-terraform*/${var.module_customer_namespace}",
    ]
  }

  statement {
    actions = [
        "codedeploy:ContinueDeployment",
        "codedeploy:ListApplications",
        "codedeploy:ListDeploymentConfigs",
        "codedeploy:ListOnPremisesInstances",
        "codedeploy:PutLifecycleEventHookExecutionStatus",
        "codedeploy:StopDeployment",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:PutMetricAlarm",
        "s3:ListBucket", // from our s3 policy
        "ecs:*", // lifted from ecs policy
        "elasticloadbalancing:*", // lifted from ecs policy
        "ec2:Describe*",
        "tag:*",
      ]
    resources = [ "*" ]
  }


 statement {
    effect = "Allow"
    actions = [ "iam:PassRole" ]
    resources = [ "*" ]
     condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values = [ "ecs-tasks.amazonaws.com", ]
    }
  }
}
