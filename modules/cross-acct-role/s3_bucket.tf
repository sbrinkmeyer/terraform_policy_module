// creates the s3 usable resource by the customer in the target account and region

resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "${lower(var.customer_name)}-${lower(var.prefix_option)}${lower(var.target_nickname)}-${var.region_id}"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${lower(var.customer_name)}-${lower(var.target_nickname)}-${var.region_id}"
    },
  )
  count = var.s3_refactor == "0" ? 1 : 0
}

