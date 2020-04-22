//output.tf

output "sizes" {
  value = module.managed_policies_module.json_size_map
}

output "build_agent_role" {
  value = aws_iam_role.cross_account_role.name
}

output "sso_user_role" {
  value = aws_iam_role.userRole.name
}

output "efs_arns" {
  value = module.efs_v2.efs_arns
}

output "efs_drives" {
  value = module.efs_v2.efs_drives
}

output "s3_bucket" {
  value = aws_s3_bucket.terraform_bucket.*.id
}

output "route53_zone_id" {
  value = aws_route53_zone.env_name.*.zone_id
}

output "route53_zone_name" {
  value = aws_route53_zone.env_name.*.name
}

