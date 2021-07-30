output "name" {
  description = "Full name of the subdomain"
  value       = aws_route53_zone.subdomain.name
}

output "subdomain_zone_id" {
  description = "Zone ID of the subdomain hosted zone"
  value       = aws_route53_zone.subdomain.zone_id
}
