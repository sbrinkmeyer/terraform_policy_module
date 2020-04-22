dms.md

# Purpose
iam implementation of a namespace dms.  update release

# thing

## Namespaced arn
will need to namespace all your dms items where the Name tag starts with your NAMESPACE-
    * ReplicationInstance
    * ReplicationTask
    * Endpoint
    * Certificate
    * EventSubscription
    * ReplicationSubnetGroup

## example

### terraform
```
variable "namespace" {
  type        = "string"
  default     = "catscratch"
}

data "aws_vpc" "nike" {
  cidr_block = "10.*"
}

data "aws_subnet_ids" "rds" {
  vpc_id = "${data.aws_vpc.nike.id}"

  tags = {
    cats-usage = "database"
  }
}

data "aws_subnet" "database" {
  for_each = data.aws_subnet_ids.rds.ids
    id = "${each.value}"
}


data "aws_iam_policy_document" "dms-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["dms.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "dms-endpoint-access" {
  assume_role_policy = "${data.aws_iam_policy_document.dms-assume-role.json}"
  name               = "catscratch-dms-endpoint-access-role"
}

resource "aws_iam_role_policy_attachment" "catscratch-dms-s3-access" {
  policy_arn = "arn:aws:iam::672714205403:policy/catscratch-s3-policy"
  role       = "${aws_iam_role.dms-endpoint-access.name}"
}

resource "aws_iam_role" "dms-logs-role" {
  assume_role_policy = "${data.aws_iam_policy_document.dms-assume-role.json}"
  name               = "catscratch-dms-cloudwatch-logs-role"
}

resource "aws_iam_role_policy_attachment" "cloudwatch-logs-access" {
  policy_arn = "arn:aws:iam::672714205403:policy/catscratch-cloudwatchlogs-policy"
  role       = "${aws_iam_role.dms-logs-role.name}"
}

resource "aws_iam_role" "dms-ec2-role" {
  assume_role_policy = "${data.aws_iam_policy_document.dms-assume-role.json}"
  name               = "catscratch-dms-ec2-role"
}

resource "aws_iam_role_policy_attachment" "dms-ec2-access" {
  policy_arn = "arn:aws:iam::672714205403:policy/catscratch-ec2-policy"
  role       = "${aws_iam_role.dms-ec2-role.name}"
}

# Create a new replication instance
resource "aws_dms_replication_instance" "dms-test-instance" {
  allocated_storage            = 20
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  availability_zone            = "us-west-2c"
  publicly_accessible          = false
  replication_instance_class   = "dms.t2.micro"
  replication_instance_id      = "catscratch-dms-replication-instance-tf"
  replication_subnet_group_id  = "${aws_dms_replication_subnet_group.dms-subnetgroup-test.id}"

  tags = {
    Name = "catscratch-dms-replication-test"
  }
}

resource "aws_dms_endpoint" "dms-endpoint-source-test" {
  endpoint_id                 = "catscratch-dms-endpoint-source-tf"
  endpoint_type               = "source"
  engine_name                 = "aurora"
  username                    = "waffles0x07b63"
  password                    = "ainttelling"
  server_name                 = "dms-source-test"
  port                        = 3306

  tags = {
    Name = "catscratch-dms-source-test"
  }
}


resource "aws_dms_endpoint" "dms-endpoint-target-test" {
  endpoint_id                 = "catscratch-dms-endpoint-target-tf"
  endpoint_type               = "target"
  engine_name                 = "aurora"
  username                    = "waffles0x07b63"
  password                    = "ainttelling"
  server_name                 = "dms-target-test"
  port                        = 3306

  tags = {
    Name = "catscratch-dms-target-test"
  }
}

resource "aws_dms_replication_subnet_group" "dms-subnetgroup-test" {
  replication_subnet_group_description = "catscratch replication subnet group"
  replication_subnet_group_id          = "catscratch-dms-replication-subnet-group-tf"

  subnet_ids = "${tolist(data.aws_subnet_ids.rds.ids)}"

  tags = {
    Name = "catscratch-dms-subnetgroup"
  }
}

resource "aws_dms_replication_task" "dms-test" {
  migration_type            = "full-load"
  replication_instance_arn  = "${aws_dms_replication_instance.dms-test-instance.replication_instance_arn}"
  replication_task_id       = "catscratch-dms-replication-task-tf"
  source_endpoint_arn       = "${aws_dms_endpoint.dms-endpoint-source-test.endpoint_arn}"
  table_mappings            = "{\"rules\":[{\"rule-type\":\"selection\",\"rule-id\":\"1\",\"rule-name\":\"1\",\"object-locator\":{\"schema-name\":\"%\",\"table-name\":\"%\"},\"rule-action\":\"include\"}]}"

  tags = {
    Name = "catscratch-dms-repltask"
  }

  target_endpoint_arn = "${aws_dms_endpoint.dms-endpoint-target-test.endpoint_arn}"
}



output "aws_subnet-subnets" {
  value="${data.aws_subnet.database}"
}

output "aws_subnet_ids-subnets" {
  value="${data.aws_subnet_ids.rds.ids}"
}
```


### cloudformation

