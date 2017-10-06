//elasticache.tf

data "aws_iam_policy_document" "elasticache_pd" {
  statement {
    effect = "Allow"

    actions = [
      "elasticache:Describe*",
      "elasticache:List*",
      "elasticache:AddTagsToResource",
      "elasticache:CreateCacheCluster",
      "elasticache:CreateReplicationGroup",
      "elasticache:CreateCacheParameterGroup",
      "elasticache:Delete*",
      "elasticache:ModifyCacheParameterGroup",
      "elasticache:CreateCacheSubnetGroup",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:DescribeAlarms",
      "sns:ListTopics",
      "sns:ListSubscriptions",
    ]

    resources = [
      "*",
    ]
  }
}
