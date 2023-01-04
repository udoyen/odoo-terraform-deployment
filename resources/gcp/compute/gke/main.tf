# The value of {var.cluster_name} will change for the two environments of the project, 
# ie two different clusters will create for production and staging. These two clusters 
# will build on the same network but on different subnets. With ip_allocation_policy, 
# we must specify the internal IP range for the cluster and services.

resource "google_container_cluster" "primary" {
  provider                 = google-beta
  name                     = "${var.project_id}-gke-cluster"
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1

  # master_authorized_networks_config block required for access the master 
  # from internal IP addresses other than nodes and Pods. Address ranges that you 
  # have authorized and this block brings back a publicly accessible endpoint.
  master_authorized_networks_config { # INFO: Required for access for private endpoints
    cidr_blocks {

      cidr_block   = "0.0.0.0/0" #according to cidr notation
      display_name = "all"
    }

  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.pod_ip_range
    services_ipv4_cidr_block = var.service_ip_range
  }

  network    = var.network_name
  subnetwork = var.cluster_subnet
  private_cluster_config {
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ip_range
    enable_private_endpoint = false
  }
  master_auth { # TODO: Investigate this
    client_certificate_config {
      issue_client_certificate = true # TODO: Investigate this
    }
  }
}


# INFO: 
# One important point is the remove_default_node_pool variable. 
# The value of this variable is True, so we don’t want it to be the default 
# node pool when the cluster is created. The interesting point here is that; 
# with this variable, Terraform first creates the default node pool and then deletes it. 
# We’ll add an external node pool that will be autoscaled because it doesn’t form at all what we expect. 
# Terraform did this because of a gcloud command constraint. Because of the GCP constraint, 
# unable to modify existing configs in Terraform when creating a cluster, so it is created and then deleted.

resource "google_container_node_pool" "default" {
  provider   = google-beta
  name       = var.node_pool_name
  cluster    = google_container_cluster.primary.id
  node_count = var.default_pool_number
  autoscaling {
    min_node_count = var.default_pool_min_node
    max_node_count = var.default_pool_max_node
  }
  node_config {
    machine_type = var.machine_type
    image_type   = var.image_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
    service_account = var.service_account
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
