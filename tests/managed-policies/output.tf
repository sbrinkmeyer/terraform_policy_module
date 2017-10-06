//output.tf


// output "all_policies_list" {
//   value = "${aws_iam_policy_document.*.json}"
// }


output "sizes" {
      value = "${module.managed_policies_module.json_size_map}"
}

output "base" {
      value = "${module.managed_policies_module.json_out_map["base"]}"
}
//  name = "${var.tenant_namespace}-${element(var.managed_policies,count.index)}-policy"
//  path = "/"
//  description = "a policy for testing ${count.index}"
//  policy = "${module.managed_policies_module.json_out_map[element(var.managed_policies,count.index)]}"
//  count = "${length(var.managed_policies)}"
//}

