terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      configuration_aliases = [aws.root, aws.subdomain]
      source                = "hashicorp/aws"
      version               = "~> 4.0"
    }
  }
}
