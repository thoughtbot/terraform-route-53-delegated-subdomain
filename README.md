# Route 53 Delegated Subdomain Terraform Module

Creates a Route 53 hosted zone for a subdomain delegated from another hosted
zone. You can use this module to create restricted hosted zones for specific
environments, or to allow another account to manage record sets for a specific
subdomain.

## Example

```
terraform {
  backend "s3" {}

  required_providers {
    aws       = {
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  alias  = "network"
  region = "us-west-2"
}

provider "aws" {
  region = "us-west-2"
  alias  = "staging"
}

module "subdomain" {
  source = "git@github.com:thoughtbot/terraform-route-53-delegated-subdomain.git?ref=v0.1.0"

  providers = {
    aws.root      = aws.network
    aws.subdomain = aws.staging
  }

  root_domain_name = "example.com"
  subdomain        = "staging"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.root"></a> [aws.root](#provider\_aws.root) | ~> 4.0 |
| <a name="provider_aws.subdomain"></a> [aws.subdomain](#provider\_aws.subdomain) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.ns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.subdomain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_root_domain_name"></a> [root\_domain\_name](#input\_root\_domain\_name) | Domain name (ie example.com) for the root hosted zone | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | Subdomain (ie www) for which a hosted zone should be delegated | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags which should be applied to created resources | `map(string)` | `{}` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | TTL value for NS DNS records | `number` | `3600` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | Full name of the subdomain |
| <a name="output_subdomain_zone_id"></a> [subdomain\_zone\_id](#output\_subdomain\_zone\_id) | Zone ID of the subdomain hosted zone |
<!-- END_TF_DOCS -->

## Contributing

Please see [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

This module is Copyright © 2021 Joe Ferris and thoughtbot. It is free
software, and may be redistributed under the terms specified in the [LICENSE]
file.

[LICENSE]: ./LICENSE

About thoughtbot
----------------

![thoughtbot](https://thoughtbot.com/brand_assets/93:44.svg)

This module is maintained and funded by thoughtbot, inc. The names and logos
for thoughtbot are trademarks of thoughtbot, inc.

We love open source software! See [our other projects][community] or [hire
us][hire] to design, develop, and grow your product.

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com/hire-us?utm_source=github
