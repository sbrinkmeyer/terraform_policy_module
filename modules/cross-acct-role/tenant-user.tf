resource "aws_iam_user" "build_user" {
  name = "s.${var.customer_name}-builduser"
  tags = merge(
    var.tags,
    {
      "Name" = format("%s-%s", lower(var.customer_name), "builduser")
    },
  )
}

resource "aws_iam_user_policy_attachment" "build_user_iam" {
  user       = aws_iam_user.build_user.name
  policy_arn = "arn:${var.partition}:iam::${var.target_account_id}:policy/${var.customer_name}-iam-policy"
  depends_on = [aws_iam_policy.always_policies]
}

resource "aws_iam_user_policy_attachment" "build_user_s3" {
  user       = aws_iam_user.build_user.name
  policy_arn = "arn:${var.partition}:iam::${var.target_account_id}:policy/${var.customer_name}-s3-policy"
  depends_on = [aws_iam_policy.always_policies]
}

//CAT-1137
/*
resource "aws_iam_user_policy_attachment" "build_user_cloudformation" {
  user       = "${aws_iam_user.build_user.name}"
  policy_arn = "arn:${var.partition}:iam::${var.target_account_id}:policy/${var.customer_name}-cloudformation-policy"
  depends_on = ["aws_iam_policy.always_policies"]
}
*/

resource "aws_iam_user_policy_attachment" "build_user_dynamodb" {
  user       = aws_iam_user.build_user.name
  policy_arn = "arn:${var.partition}:iam::${var.target_account_id}:policy/${var.customer_name}-dynamodb-policy"
  depends_on = [aws_iam_policy.always_policies]
}

resource "aws_iam_user_policy_attachment" "build_user_ec2" {
  user       = aws_iam_user.build_user.name
  policy_arn = "arn:${var.partition}:iam::${var.target_account_id}:policy/${var.customer_name}-ec2-policy"
  depends_on = [aws_iam_policy.always_policies]
}

resource "aws_iam_user_policy" "assume_buildagent_role" {
  name       = "${var.customer_name}-assume_ba_role"
  user       = aws_iam_user.build_user.name
  depends_on = [aws_iam_role.cross_account_role]

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Resource": "arn:${var.partition}:iam::${var.target_account_id}:role/${var.customer_name}BuildAgentRole"
    }
  ]
}
EOF

}

