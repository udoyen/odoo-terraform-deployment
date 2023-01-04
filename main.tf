terraform {
  backend "gcs" {
    bucket = "odoo-project-tfstate"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.33.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }

    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = "2.13.1"
    # }
  }

  required_version = ">=1.1.0"


}

locals {
  project_id         = "qwiklabs-gcp-00-617cdbf80b23" # TODO: Update this
  project_tag        = "techequity-odoo"
  endpoint           = module.main.gke.endpoint
  cluster_name  = module.main.gke.cluster_name
  master_ca          = module.main.gke.master_certificate
  client_key         = module.main.gke.client_key
  client_certificate = module.main.gke.client_certificate
  helm_version       = "v2.9.1"
  zone               = "us-central1-a" # used to choose the default location for zonal resources. Zonal resources exist in a single zone. All zones are a part of a region.
}


# provider "kubernetes" {

# }

provider "google" {
  project = local.project_id
  region  = var.region
  zone    = local.zone

  scopes = [
    # Default scopes
    "https://www.googleapis.com/auth/compute",

    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",

    # Required for google_client_openid_userinfo
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

provider "google-beta" {
  project = local.project_id
  region  = var.region
  zone    = local.zone

  scopes = [
    # Default scopes
    "https://www.googleapis.com/auth/compute",

    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",

    # Required for google_client_openid_userinfo
    "https://www.googleapis.com/auth/userinfo.email",
  ]

}


data "google_client_config" "client" {
  
}

# Configure Helm provider with OAuth2 access token
provider "helm" {
  # service_account = module.kubernetes.helm_service_account_name
  # tiller_image    = "gcr.io/kubernetes-helm/tiller:${local.helm_version}"
  # install_tiller = false # Temporary
  kubernetes {
    token = data.google_client_config.client.access_token
    host  = local.endpoint
    cluster_ca_certificate = base64decode(local.master_ca)

    exec {
      api_version = "client.authentication.k8s.io/v1"
      args = ["container", "clusters", "get-credentials", local.cluster_name]
      command = "gcloud"
    }

    # client_certificate     = base64decode(local.client_certificate)
    # client_key             = base64decode(local.client_key)
  }

}


module "main" {
  source                   = "./development"
  project_tag              = local.project_tag
  default_tags             = var.default_tags
  project_id               = local.project_id
  odoo_postgresql_password = var.odoo_postgresql_password
  gcp_project              = local.project_id
}
