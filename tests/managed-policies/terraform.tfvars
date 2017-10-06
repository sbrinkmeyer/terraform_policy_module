//terraform.tfvars
tenant_namespace="scott"
managed_policies=["cloudformation", "cloudwatchlogs", "dynamodb", "ec2", "ecs", "efs", "iam", "s3", "sns"]
account_id="ACCOUNT_ID"
target_region="us-east-1"
target_moniker="non"
target_tstate="BUCKET_DYNAMODB-us-east-1"
target_vpc="vpc-IDENTIFIER"
target_efs_fsid="fs-SAMPLE"