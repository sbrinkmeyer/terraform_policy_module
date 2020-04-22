// creates the s3 usable resource by the customer in the target account and region
provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "${lower(var.namespace)}-${lower(var.target_nickname)}-${var.region}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${lower(var.namespace)}-${lower(var.target_nickname)}-${var.region}"
    },
  )
}

