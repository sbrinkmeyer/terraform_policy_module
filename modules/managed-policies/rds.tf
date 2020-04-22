//rds.tf

// Avoid TF freaking out about embedded quotes
locals {
  neptune_namespaced = "arn:${var.partition}:neptune-db:*:${var.module_account_id}:${var.module_customer_namespace}-*/*"
}

data "aws_iam_policy_document" "rds_pd" {
  statement {
    sid       = "AllowRDSDescribe"
    effect    = "Allow"
    actions   = ["rds:Describe*"]
    resources = ["*"]
  }

  statement {
    sid     = "AllowRDSManagementByNamespace"
    effect  = "Allow"
    actions = ["rds:*"]

    resources = [
      "arn:${var.partition}:rds:*:*:*:${lower(var.module_customer_namespace)}.*",
      "arn:${var.partition}:rds:*:*:*:${lower(var.module_customer_namespace)}*",
      "arn:${var.partition}:rds:*:*:cluster-pg*",
      "arn:${var.partition}:rds:*:*:subgrp:*",
      "arn:${var.partition}:rds:*:*:pg*",
      "arn:${var.partition}:rds:*:*:og*",
    ]
  }

  statement {
    actions   = ["rds:Download*"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "rds:db-tag/Name"
      values   = ["${var.module_customer_namespace}*"]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["neptune-db:*"]
    resources = compact(concat([local.neptune_namespaced], var.neptune_arns))
  }

  statement {
    effect	= "Allow"
    resources	= [ "*" ]
    actions	= [
	"rds-data:BatchExecuteStatement",
	"rds-data:BeginTransaction",
	"rds-data:CommitTransaction",
	"rds-data:ExecuteStatement",
	"rds-data:RollbackTransaction"
    ]
  }
}

