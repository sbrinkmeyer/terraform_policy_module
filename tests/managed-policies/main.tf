//main.tf

module "managed_policies_module" {
    source                      =   "./modules/managed-policies"
    module_tenant_namespace   =   "${var.tenant_namespace}"
    module_account_id           =   "${var.account_id}"
    module_target_region        =   "${var.target_region}"
    module_target_moniker       =   "${var.target_moniker}"
    module_hosted_zone          =   "${var.hosted_zone}"
    module_target_tstate        =   "${var.target_tstate}"
    module_target_vpc           =   "${var.target_vpc}"
    module_target_efs_fsid      =   "${var.target_efs_fsid}"
//    count = "${length(var.policy_data_files)}"
}

resource "aws_iam_policy" "poc_policies" {
  name = "${var.tenant_namespace}-${element(var.managed_policies,count.index)}-policy"
  path = "/"
  description = "${var.tenant_namespace} policy for ${element(var.managed_policies,count.index)}"
  policy = "${module.managed_policies_module.json_out_map[element(var.managed_policies,count.index)]}"
  count = "${length(var.managed_policies)}"
}

