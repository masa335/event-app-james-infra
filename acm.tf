resource "aws_acm_certificate" "james-acm" {
  domain_name = data.aws_route53_zone.james_route53_zone.name
  subject_alternative_names = []
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "james_certificate" {
   for_each = {
     for dvo in aws_acm_certificate.james-acm.domain_validation_options : dvo.domain_name => {
       name   = dvo.resource_record_name
       record = dvo.resource_record_value
       type   = dvo.resource_record_type
     }
   }
 
   allow_overwrite = true
   name            = each.value.name
   records         = [each.value.record]
   ttl             = 60
   type            = each.value.type
   zone_id         = data.aws_route53_zone.james_route53_zone.zone_id
}
 
# 検証の待機
resource "aws_acm_certificate_validation" "james" {
   certificate_arn = aws_acm_certificate.james-acm.arn
   validation_record_fqdns = [for record in aws_route53_record.james_certificate : record.fqdn]
}