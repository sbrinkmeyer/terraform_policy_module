//output.tf

output "efs_drives" {
  value = aws_efs_file_system.policy_created_efs.*.id
}

output "efs_arns" {
  value = formatlist(
    "arn:%s:elasticfilesystem:*:%s:file-system/%s",
    var.partition,
    var.target_account_id,
    aws_efs_file_system.policy_created_efs.*.id,
  )
}

