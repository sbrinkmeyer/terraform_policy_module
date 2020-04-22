redshift.md

# Purpose
iam implementation of a namespace redshift.  initial release

# thing

## Namespaced arn
will need to namespace all your redshift items
  * cluster:${lower(var.module_customer_namespace)}-*"
  * snapshot:${lower(var.module_customer_namespace)}-*/*"
  * parametergroup:${lower(var.module_customer_namespace)}-*"
  * eventsubscription:${lower(var.module_customer_namespace)}-*"
  * hsmclientcertificate:${lower(var.module_customer_namespace)}-*"
  * hsmconfiguration:${lower(var.module_customer_namespace)}-*"
  * snapshotcopygrant:${lower(var.module_customer_namespace)}-*"
  * securitygroup:${lower(var.module_customer_namespace)}-*"
  * subnetgroup:${lower(var.module_customer_namespace)}-*"

## example

### terraform
```
variable "namespace" {
  type        = "string"
  default     = "myname0x987abc"
}
resource "role" "role" {}

resource "aws_redshift_cluster" "namespaced_redshift_cluster" {
  cluster_identifier = "${lower(var.namespace)}-redshift-cluster"
  database_name      = "${lower(var.namespace)}-mydb"
  master_username    = "foo"
  master_password    = "Mustbe8characters"
  node_type          = "dc1.large"
  cluster_type       = "single-node"
}

```

### cloudformation

