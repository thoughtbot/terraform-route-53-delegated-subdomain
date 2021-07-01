resource "aws_route53_zone" "subdomain" {
  provider = aws.subdomain

  name = "${var.subdomain}.${data.aws_route53_zone.root.name}"
  tags = var.tags
}

resource "aws_route53_record" "ns" {
  provider = aws.root

  name    = aws_route53_zone.subdomain.name
  records = aws_route53_zone.subdomain.name_servers
  ttl     = var.ttl
  type    = "NS"
  zone_id = data.aws_route53_zone.root.zone_id
}

resource "aws_route53_record" "alias" {
  for_each = var.aliases
  provider = aws.root

  name    = each.key
  type    = "A"
  zone_id = data.aws_route53_zone.root.zone_id

  alias {
    evaluate_target_health = true
    name                   = each.value
    zone_id                = aws_route53_zone.subdomain.zone_id
  }
}


data "aws_route53_zone" "root" {
  provider = aws.root

  name = var.root_domain_name
}
