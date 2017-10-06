#policy-module

## Problem Statement(s)
Hard coding and hand wiring of policies make reuse very difficult and time consuming.
Continued copy|pasta is a nightmare just waiting to happen
Reading of the mangled policies is very difficult

### solution
make a reusable expandable policy system that doesn't rely on home made solutions or a lot of stitch and glue implementation with other systems
no additional tools needed.
allows for cloning/forking of a repo for additions to policy using a pr process

### implementation
creation of a module that has the policies encoded using the policy document format for terraform.  this way you can reuse variables passed in to this.
requires that as policies are created the module output map is updated with the new name
names in map, will need to match the consumers required array

#### example
main.tf
```
module "managed_policies_module" {
    source                      =   "git@github.com:sbrinkmeyer/terraform_policy_module"
    module_tenant_namespace   =   "${var.tenant_namespace}"
    module_account_id           =   "${var.account_id}"
    module_target_region        =   "${var.target_region}"
}

resource "aws_iam_policy" "poc_policies" {
  name = "${var.tenant_namespace}-policy-${count.index}"
  path = "/"
  description = "a policy for testing ${count.index}"
  policy = "${module.managed_policies_module.json_out_map[element(var.managed_policies,count.index)]}"
  count = "${length(var.managed_policies)}"
}
```

terraform.tfvars
```
// array of consumers required managed policies
managed_policies=["elasticache","cloudwatchlogs"]
```

#### required inputs
* tenant namespace
* account id
* target region
- others

#### required reading
good luck on iam permissions per service