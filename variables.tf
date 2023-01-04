variable "default_tags" {
  type        = map(string)
  description = "A map of tags that will be applied to all resources"
  default = {
    "Environment" = "dev"
    "Manager"     = "terraform"
  }
}

variable "vpc_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "odoo-vpc"
}


# variable "secrets" {
#   type = map(string)
#   sensitive  = true
#   description = "(optional) describe your variable"
# }

variable "odoo_postgresql_password" {
  type        = string
  sensitive   = true
  description = "(optional) describe your variable"
}

variable "region" {
  type        = string
  description = "(optional) describe your variable"
  default     = "us-central1"
}
