resource "google_compute_router" "project-router" {
  name = "${var.vpc_name}-nat-router"
  # network = "${google_compute_network.project-network.self_link}"  # TODO:  add network name using variable
  network = var.vpc_name

  tags = merge(
    var.default_tags,
    {
      Name = "${var.default_tag}-comput-router"
    }
  )
}