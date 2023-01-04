variable "project_tag" {
  type        = string
  description = "Project tag"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags"
  default = {
    "Environment" = "dev"
    "Manager"     = "terraform"
  }
}

variable "machine_type" {
  type        = string
  description = "Machine type"
  default     = "e2-medium"
}

variable "default_pool_number" {
  type        = number
  description = "Default pool number"
  default     = 1
}

variable "default_pool_name" {
  type        = string
  description = "Default pool name"
  default     = "odoo-defautl-pool"
}

variable "master_ip_range" {
  type        = string
  description = "Master IP range"
  default     = "172.16.0.32/28"
}

variable "service_ip_range" {
  type        = string
  description = "Service IP range"
  default     = "10.30.0.0/21" # TODO: Resolve this with a suitable range of say 10.128.0.0/20 and secondary subnets of 10.8.0.0/17, 10.128.0/22

}
variable "pod_ip_range" {
  type        = string
  description = "(optional) describe your variable"
  default     = "10.20.0.0/21"
}

variable "subnet_cidr" {
  type        = string
  description = "(optional) describe your variable"
  default     = "10.10.0.0/24"
}


# variable "gke_version" {
#     type = string
#     description = "(optional) describe your variable"
# }

variable "cluster_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "odoo-cluster"
}

variable "region" {
  type        = string
  description = "(optional) describe your variable"
  default     = "us-central1"
}

variable "gcp_project" {
  type        = string
  description = "(optional) describe your variable"
}


variable "vpc_name" {
  type        = string
  description = "VPC name"
  default     = "odoo-vpc"
}

variable "default_pool_max_node" {
  type        = number
  description = "(optional) describe your variable"
  default     = 2
}

variable "default_pool_min_node" {
  type        = number
  description = "(optional) describe your variable"
  default     = 1

}

variable "iam_roles" {
  type        = list(string)
  description = "(optional) describe your variable"
  default = [
    "roles/compute.viewer",
    "roles/compute.securityAdmin",
    "roles/container.clusterAdmin",
    "roles/container.developer",
    "roles/iam.serviceAccountUser",
    "roles/resourcemanager.projectIamAdmin"
  ]

}

# variable "gke_master_password" {
#     type = string
#     sensitive = true
#     description = "(optional) describe your variable"
# }

# variable "gke_master_username" {
#     type = string
#     sensitive = true
#     description = "(optional) describe your variable"
# }

variable "project_id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "image_type" {
  type        = string
  description = "(optional) describe your variable"
  default     = "COS_CONTAINERD"
}

variable "odoo_postgresql_password" {
  type        = string
  sensitive   = true
  description = "(optional) describe your variable"
}

variable "cloud_nat_ips" {
  type        = number
  description = "(optional) describe your variable"
  default     = 2
}

variable "node_pool_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "odoo-cluster-node-pool"
}

variable "helm_service_account_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "odoo-cluster-helm-account"
}
# variable "secrets" {
#     type = map(string)
#     sensitive = true
#     description = "(optional) describe your variable"
# }

