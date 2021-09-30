data "aws_route53_zone" "james_route53_zone" {
  name = "masa335.link"
}

resource "aws_route53_record" "james_route53_record" {
  zone_id = data.aws_route53_zone.james_route53_zone.zone_id
  name = data.aws_route53_zone.james_route53_zone.name
  type = "A"

  alias {
    name = aws_alb.james_alb.dns_name
    zone_id = aws_alb.james_alb.zone_id
    evaluate_target_health = true
  }
}