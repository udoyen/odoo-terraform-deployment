output "endpoint" {
  value = google_container_cluster.primary.endpoint
}


output "master_certificate" {
  value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}


output "client_certificate" {
  value = google_container_cluster.primary.master_auth.0.client_certificate
}

output "client_key" {
  value = google_container_cluster.primary.master_auth.0.client_key
}

output "cluster_name" {
  value = google_container_cluster.primary.id
}

output "cluster_locaton" {
  value = google_container_cluster.primary.location
}