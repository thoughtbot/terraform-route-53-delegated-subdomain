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

data "aws_route53_zone" "root" {
  provider = aws.root

  name = var.root_domain_name
}
