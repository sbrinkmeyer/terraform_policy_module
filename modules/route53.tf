//route53.tf

data "aws_iam_policy_document" "route53_pd" {
  statement {
    effect = "Allow"

    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ChangeTagsForResource",
    ]

    resources = [
      "arn:aws:route53:::hostedzone/${var.module_hosted_zone}",
      "arn:aws:route53:::hostedzone/${var.module_hosted_zone}/",
      "arn:aws:route53:::healthcheck/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "route53:Get*",
      "route53:List*",
      "route53:TestDNSAnswer",
      "route53domains:Get*",
      "route53domains:List*",

      //  require * resource
      "route53:CreateHealthCheck",

      "route53:DeleteHealthCheck",
      "route53:GetCheckerIpRanges",
      "route53:GetHealthCheck",
      "route53:GetHealthCheckCount",
      "route53:GetHealthCheckLastFailureReason",
      "route53:GetHealthCheckStatus",
      "route53:ListHealthChecks",
      "route53:UpdateHealthCheck",
    ]

    resources = ["*"]
  }
}
