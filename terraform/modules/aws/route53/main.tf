resource "aws_route53_zone" "gigachad" {
  name     = "gigachad.smodata.net"
}

resource "aws_route53_record" "myRecord" {
  name            = "api.gigachad.smodata.net"
  type            = "A"
  zone_id         = aws_route53_zone.gigachad.zone_id

  records = aws_route53_zone.gigachad.name_servers
}

resource "aws_route53_record" "CName" {
  zone_id = aws_route53_zone.gigachad.zone_id
  name = "cname.api.gigachad.smodata.net"
  type = "CNAME"
  ttl = 1800

  records = aws_route53_zone.gigachad.name_servers 
}
