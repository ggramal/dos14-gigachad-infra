locals {
  route53 = {
    zone_name       = "gigachad.smodata.net"
    record_name     = "api.gigachad.smodata.net"
    record_type     = "A"
    cname_records = {
      "cname_record_1" = {
        cname_record_name   = "cname.api.gigachad.smodata.net"
        cname_record_type   = "CNAME"
        cname_record_ttl    = 300
        cname_record_value  = [module.alb.alb_public_url]
      }
    }
  }
}