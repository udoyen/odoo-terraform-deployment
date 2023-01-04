module "gke" {
  source                = "../resources/gcp/compute/gke"
  pod_ip_range          = var.pod_ip_range
  service_ip_range      = var.service_ip_range
  network_name          = module.vpc_network.vpc_name
  master_ip_range       = var.master_ip_range
  default_pool_number   = var.default_pool_number
  machine_type          = var.machine_type
  service_account       = module.iam_roles.service_account
  default_pool_max_node = var.default_pool_max_node
  default_pool_min_node = var.default_pool_min_node
  project_id            = var.project_id
  cluster_subnet        = module.vpc_network.cluster_subnet
  image_type            = var.image_type
  region                = var.region
  node_pool_name        = var.node_pool_name
}

# module "kubernetes" {
#   source                    = "../resources/kubernetes"
#   helm_service_account_name = var.helm_service_account_name
#   cluster_name              = module.gke.cluster_name
# }

module "iam_roles" {
  source       = "../resources/gcp/iam"
  cluster_name = var.cluster_name
  iam_roles    = var.iam_roles
  project_id   = var.project_id

}


module "vpc_network" {
  source        = "../resources/gcp/network/vpc_nework"
  region        = var.region
  gcp_project   = var.gcp_project
  cloud_nat_ips = var.cloud_nat_ips
  vpc_name      = var.vpc_name
  subnet_cidr   = var.subnet_cidr
  service_range = var.service_ip_range
  pod_range     = var.pod_ip_range
  # cluster_firewall_rule_priority = var.cluster_firewall_rule_priority

}


# module "cloud_nat" {
#     source = "../resources/gcp/network/services/cloud_nat"
#     nat_ips = module.vpc_network.nat_ips
#     vpc_name = module.vpc_network.vpc_name
#     project_tag = var.project_tag
#     default_tags = var.default_tags

# }


# module "cloud_router" {
#     source = "../resources/gcp/network/services/cloud_router"
#     project_tag = var.project_tag
#     default_tags = var.default_tags
#     vpc_name = module.vpc_network.vpc_name

# }


module "cloud_dns" {
  source = "../resources/gcp/network/services/dns"

}

module "helm" {
  source                   = "../resources/helm"
  odoo_postgresql_password = var.odoo_postgresql_password
  project_id               = var.project_id
  cluster_name             = module.gke.cluster_name

}

# module "secrets" {
#     source = "../resources/gcp/secrets"
#     secrets = var.secrets
#     project_id = var.project_id
# }

