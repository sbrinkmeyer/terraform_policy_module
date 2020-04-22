codedeploy.md

# Purpose
iam implementation of a namespace codedeploy.  initial release

# thing

## Namespaced arn
will need to namespace all the following codedeploy items
  * "arn:${var.partition}:codedeploy:*:${var.module_account_id}:application/${lower(var.module_customer_namespace)}-*",
  * "arn:${var.partition}:codedeploy:*:${var.module_account_id}:deploymentgroup/${lower(var.module_customer_namespace)}-*",
  * "arn:${var.partition}:codedeploy:*:${var.module_account_id}:deploymentconfig/${lower(var.module_customer_namespace)}-*",

## example

### terraform
```

https://www.terraform.io/docs/providers/aws/r/codedeploy_app.html
https://www.terraform.io/docs/providers/aws/r/codedeploy_deployment_group.html
https://www.terraform.io/docs/providers/aws/r/codedeploy_deployment_config.html

```

### cloudformation

