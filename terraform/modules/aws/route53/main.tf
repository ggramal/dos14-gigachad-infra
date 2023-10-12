resource "aws_route53_zone" "gigachad" {
  name = var.zone_name
}

# data "aws_lb_hosted_zone_id" "main" {}

resource "aws_route53_record" "main" {
  zone_id = aws_route53_zone.gigachad.zone_id
  name    = var.record_name
  type    = var.record_type
  alias {
    name                   = var.dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cname_record" {
  for_each = var.cname_records
  zone_id  = aws_route53_zone.gigachad.zone_id
  name     = each.value.cname_record_name
  type     = each.value.cname_record_type
  ttl      = each.value.cname_record_ttl
  records  = each.value.cname_record_value
}