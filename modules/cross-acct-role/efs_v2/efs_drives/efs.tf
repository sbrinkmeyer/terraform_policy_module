//efs.tf

provider "aws" {
  region = var.region
}

resource "aws_efs_file_system" "policy_created_efs" {
  tags = merge(
    var.tags,
    {
      "Name" = format(
        "%s-%s-%s-%02d",
        lower(var.customer_name),
        lower(var.target_nickname),
        var.region,
        count.index + 1,
      )
    },
  )
  count                           = var.efs_count
  throughput_mode                 = var.efs_throughput_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps

}

