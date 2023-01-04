output "nat_ips" {
  value = google_compute_address.project-nat-ips.*.id
}

output "vpc_name" {
  value = google_compute_network.project-network.id
}

output "cluster_subnet" {
  value = google_compute_subnetwork.project-subnet.name
}