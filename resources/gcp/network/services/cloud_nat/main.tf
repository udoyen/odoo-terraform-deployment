resource "google_compute_router_nat" "project-nat" {
  name                   = "${var.vpc_name}-nat-gw"
  router                 = google_compute_router.project-router.name
  nat_ip_allocate_option = "MANUAL_ONLY"
  # nat_ips = ["${google_compute_address.project-nat-ips.*.self_link}"]  # TODO: add value of nat from node folder
  nat_ips                            = [var.nat_ips] # TODO: add value of nat from node folder
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  depends_on                         = [google_compute_address.project-nat-ips] # TODO: link this to the public ip address for the project

  tags = merge(
    var.default_tags,
    {
      Name = "${var.project_tag}-compute-router-nat"
    }
  )
}