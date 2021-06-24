terraform {
  required_version = ">= 0.14.0"

  required_providers {
    aws = {
      configuration_aliases = [aws.root, aws.subdomain]
      source                = "hashicorp/aws"
      version               = "~> 3.0"
    }
  }
}
