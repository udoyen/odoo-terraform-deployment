variable "project_id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "pod_ip_range" {
  type        = string
  description = "Cluster pod ip range"
}

variable "service_ip_range" {
  type        = string
  description = "Services ip range" # TODO: Investigate
}


variable "network_name" {
  type        = string
  description = "Name of the network"
}

variable "master_ip_range" {
  type        = string
  description = "Cluster master ip range" # TODO: Investigate"
}

# variable "zone" {
#   type        = string
#   description = "Zone name" # TODO: Investigate
# }

variable "default_pool_number" {
  type        = number
  description = "Cluster default pool number"
}

variable "machine_type" {
  type        = string
  description = "Cluster node machine_type"
}

variable "image_type" {
  type        = string
  description = "(optional) describe your variable"
}

variable "service_account" {
  type        = string
  description = "Name of the service account"
}

variable "default_pool_max_node" {
  type        = number
  description = "Maximum pool size"
}

variable "default_pool_min_node" {
  type        = number
  description = "Minimum pool size"
}

# variable "gke_master_username" {
#   type = string
#   description = "(optional) describe your variable"
# }

# variable "gke_master_password" {
#   type = string
#   description = "(optional) describe your variable"
# }

variable "cluster_subnet" {
  type        = string
  description = "(optional) describe your variable"
}

variable "region" {
  type        = string
  description = "(optional) describe your variable"
}

# variable "master_username" {
#   type = string
#   description = "Master node username"
# }

# variable "master_password" {
#   type = string
#   description = "Master node password"
# }

variable "node_pool_name" {
  type        = string
  description = "(optional) describe your variable"


}

