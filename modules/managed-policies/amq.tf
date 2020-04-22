//amq.tf
data "aws_iam_policy_document" "amq_pd" {
  statement {
    sid    = "ec2PermissionsForAmq"
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DetachNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteNetworkInterfacePermission",
      "ec2:CreateNetworkInterfacePermission",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "amqoverview"
    effect = "Allow"
    actions = [
      "mq:Describe*",
      "mq:List*",
    ]

    resources = [
      "arn:${var.partition}:mq:*:${var.module_account_id}:*",
    ]
  }

  statement {
    sid    = "amqsetup"
    effect = "Allow"
    actions = [
      "mq:Create*",
      "mq:Update*",
      "mq:Delete*",
      "mq:RebootBroker",
    ]

    resources = [
      "arn:${var.partition}:mq:*:${var.module_account_id}:*",
    ]
  }
}

