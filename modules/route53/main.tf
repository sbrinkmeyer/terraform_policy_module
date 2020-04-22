//route53 tenant module
data "aws_route53_zone" "selected" {
  name = "${lower(var.target_nickname)}.${lower(var.target_account_tldn)}."
}

resource "aws_route53_zone" "env_name" {
  name = "${lower(var.customer_name)}.${lower(var.target_nickname)}.${lower(var.target_account_tldn)}"
  tags = merge(
    var.tags,
    {
      "Name" = "${lower(var.customer_name)}.${lower(var.target_nickname)}.${lower(var.target_account_tldn)}"
    },
  )
}

resource "aws_route53_record" "env-name-ns" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${lower(var.customer_name)}.${lower(var.target_nickname)}.${lower(var.target_account_tldn)}"
  type    = "NS"
  ttl     = "30"

  records = [
    aws_route53_zone.env_name.name_servers[0],
    aws_route53_zone.env_name.name_servers[1],
    aws_route53_zone.env_name.name_servers[2],
    aws_route53_zone.env_name.name_servers[3],
  ]
}

