data "aws_route53_zone" "zone" {
  name         = "eng.ziftsolutions.com."
  private_zone = true
}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${var.record_name}.${data.aws_route53_zone.zone.name}"
  type    = "A"
  alias {
    name                   = var.alias_record
    zone_id                = var.alias_zone_id
    evaluate_target_health = false
  }
}

output "route53_fqdn" {
  value =  aws_route53_record.record.fqdn
}

output "route53_alias" {
  value =  tolist(aws_route53_record.record.alias.*.name)[0]
}
