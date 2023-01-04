variable "project_tag" {
  type        = string
  description = "Resource tag"
}

variable "default_tags" {
  type        = map(string)
  description = "Tags to apply to the resources"
}

variable "vpc_name" {
  type        = string
  description = "(optional) describe your variable"
}