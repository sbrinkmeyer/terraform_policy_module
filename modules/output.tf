//output.tf

output "json_out_map" {
  value = "${
        map(
            "apigateway", "${data.aws_iam_policy_document.apigateway_pd.json}",
            "acm", "${data.aws_iam_policy_document.acm_pd.json}",
            "base", "${data.aws_iam_policy_document.base_pd.json}",
            "ro-base", "${data.aws_iam_policy_document.ro_base_pd.json}",
            "cloudformation", "${data.aws_iam_policy_document.cloudformation_pd.json}",
            "cloudwatchlogs", "${data.aws_iam_policy_document.cloudwatchlogs_pd.json}",
            "dynamodb", "${data.aws_iam_policy_document.dynamodb_pd.json}",
            "ec2", "${data.aws_iam_policy_document.ec2_pd.json}",
            "ecs", "${data.aws_iam_policy_document.ecs_pd.json}",
            "efs", "${data.aws_iam_policy_document.efs_pd.json}",
            "elasticbeanstalk", "${data.aws_iam_policy_document.elasticbeanstalk_pd.json}",
            "elasticache", "${data.aws_iam_policy_document.elasticache_pd.json}",
            "iam", "${data.aws_iam_policy_document.iam_pd.json}",
            "kinesis", "${data.aws_iam_policy_document.kinesis_pd.json}",
            "lambda", "${data.aws_iam_policy_document.lambda_pd.json}",
            "route53", "${data.aws_iam_policy_document.route53_pd.json}",
            "rds", "${data.aws_iam_policy_document.rds_pd.json}",
            "s3", "${data.aws_iam_policy_document.s3_pd.json}",
            "sns", "${data.aws_iam_policy_document.sns_pd.json}",
            "sqs", "${data.aws_iam_policy_document.sqs_pd.json}"
        )
    }"
}

output "json_size_map" {
  value = "${
        map(
            "apigateway", "${length(data.aws_iam_policy_document.apigateway_pd.json)}",
            "acm", "${length(data.aws_iam_policy_document.acm_pd.json)}",
            "base", "${length(data.aws_iam_policy_document.base_pd.json)}",
            "ro-base", "${length(data.aws_iam_policy_document.ro_base_pd.json)}",
            "cloudformation", "${length(data.aws_iam_policy_document.cloudformation_pd.json)}",
            "cloudwatchlogs", "${length(data.aws_iam_policy_document.cloudwatchlogs_pd.json)}",
            "dynamodb", "${length(data.aws_iam_policy_document.dynamodb_pd.json)}",
            "ec2", "${length(data.aws_iam_policy_document.ec2_pd.json)}",
            "ecs", "${length(data.aws_iam_policy_document.ecs_pd.json)}",
            "efs", "${length(data.aws_iam_policy_document.efs_pd.json)}",
            "elasticbeanstalk", "${length(data.aws_iam_policy_document.elasticbeanstalk_pd.json)}",
            "elasticache", "${length(data.aws_iam_policy_document.elasticache_pd.json)}",
            "iam", "${length(data.aws_iam_policy_document.iam_pd.json)}",
            "kinesis", "${length(data.aws_iam_policy_document.kinesis_pd.json)}",
            "lambda", "${length(data.aws_iam_policy_document.lambda_pd.json)}",
            "route53", "${length(data.aws_iam_policy_document.route53_pd.json)}",
            "rds", "${length(data.aws_iam_policy_document.rds_pd.json)}",
            "s3", "${length(data.aws_iam_policy_document.s3_pd.json)}",
            "sns", "${length(data.aws_iam_policy_document.sns_pd.json)}",
            "sqs", "${length(data.aws_iam_policy_document.sqs_pd.json)}"
        )
    }"
}
