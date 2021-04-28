//cerberus.tf
// docs at https://confluence.business.com/display/CPE/Cerberus+business+User+Guide
data "aws_iam_policy_document" "cerberus_pd" {
  statement {
    sid       = "CerberusPolicy"
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    /* no cerberus in china */
    resources = ["arn:aws:kms:*:933764306573:key/*"]
  }
}

