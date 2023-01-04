variable "vpc_name" {
  type        = string
  description = ""
}

variable "cloud_nat_ips" {
  type        = number
  description = "(optional) describe your variable"
}

variable "gcp_project" {
  type        = string
  description = "(optional) describe your variable"
}

variable "region" {
  type        = string
  description = "(optional) describe your variable"
}

variable "subnet_cidr" {
  type        = string
  description = "(optional) describe your variable"
}

variable "service_range" {
  type        = string
  description = "(optional) describe your variable"
}

variable "pod_range" {
  type        = string
  description = "(optional) describe your variable"
}

# variable "cluster_firewall_rule_priority" {
#   type        = number
#   description = "(optional) describe your variable"
# }

