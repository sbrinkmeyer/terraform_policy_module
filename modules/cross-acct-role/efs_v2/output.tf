//Expose the list of generated drives

//Compact is used to eliminate blank entries from the list.
output "efs_arns" {
  value = compact(
    concat(
      module.efs_us_east_1.efs_arns,
      module.efs_us_west_2.efs_arns,
      module.efs_eu_west_1.efs_arns,
    ),
  )
}

output "efs_drives" {
  value = compact(
    concat(
      module.efs_us_east_1.efs_drives,
      module.efs_us_west_2.efs_drives,
      module.efs_eu_west_1.efs_drives,
    ),
  )
}

