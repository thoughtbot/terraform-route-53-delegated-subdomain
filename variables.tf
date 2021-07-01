variable "aliases" {
  type        = map(string)
  description = "Aliases from the root domain to the subdomain"
  default     = {}
}

variable "root_domain_name" {
  type        = string
  description = "Domain name (ie example.com) for the root hosted zone"
}

variable "subdomain" {
  type        = string
  description = "Subdomain (ie www) for which a hosted zone should be delegated"
}

variable "tags" {
  type        = map(string)
  description = "Tags which should be applied to created resources"
  default     = {}
}

variable "ttl" {
  type        = number
  description = "TTL value for NS DNS records"
  default     = 3600
}
