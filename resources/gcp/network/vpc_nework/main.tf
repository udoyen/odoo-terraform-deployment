resource "google_compute_network" "project-network" {
  name                    = "${var.vpc_name}-project"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "project-subnet" {
  name                     = "${var.vpc_name}-subnetwork"
  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = true
  network                  = google_compute_network.project-network.id
}


# resource "google_compute_firewall" "project-firewall-allow-ssh-http" {
#   name    = "${var.vpc_name}-allow-ssh-http"
#   network = google_compute_network.project-network.self_link
#   allow {
#     protocol = "tcp"
#     ports    = ["22", "80", "443"]
#   }
#   # source_ranges = ["IP/range"]
#   source_ranges = ["${var.subnet_cidr}", "${var.pod_range}", "${var.service_range}"]
# }

resource "google_compute_firewall" "project_firewall-http-https-all-internet" {
  name    = "${var.vpc_name}-http-https-all-internet"
  network = google_compute_network.project-network.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# resource "google_compute_firewall" "project-firewall-pods" {
#   name    = "${var.vpc_name}-pods"
#   network = google_compute_network.project-network.self_link

#   allow {
#     protocol = "udp"
#   }

#   allow {
#     protocol = "icmp"
#   }

#   allow {
#     protocol = "esp"
#   }

#   allow {
#     protocol = "ah"
#   }

#   allow {
#     protocol = "sctp"
#   }

#   allow {
#     protocol = "tcp"
#   }


#   source_ranges = ["${var.pod_range}"]

# }

# resource "google_compute_firewall" "project-firewall-allow-icmp-on-all-ports" {
#   name    = "${var.vpc_name}-allow-icmp-on-all-ports"
#   network = google_compute_network.project-network.self_link


#   allow {
#     protocol = "icmp"

#   }

#   priority = "65534"
# }

resource "google_compute_firewall" "project-firewall-services-icmp" {
  name    = "${var.vpc_name}-icmp-services"
  network = google_compute_network.project-network.self_link

  allow {
    protocol = "icmp"
  }

  source_ranges = ["${var.service_range}"]

}

resource "google_compute_firewall" "project-firewall-services-udp" {
  name    = "${var.vpc_name}-services"
  network = google_compute_network.project-network.self_link

  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }

  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }

  source_ranges = ["${var.service_range}"]

}

# Default firewall rules for the created subnet
# resource "google_compute_firewall" "default" {
#   name    = "${var.vpc_name}-default"
#   network = google_compute_network.project-network.self_link

#   allow {
#     protocol = "tcp"
#   }
# }


# In some cases, we want to access the postgreSQL database in the same project in GCP but in a different network. 
#In such a case, we can define a firewall rule as follows

#  will assume that this database is running on a GC Compute Engine VM instance. In this case, we must define 
#the network-tag-name value as the network tag in this VM instance. Thus, when this rule create, the database 
#will accept requests from the specified pod_range on port 5432.

# resource "google_compute_firewall" "allow-db" {
#   name    = "allow-from-${var.cluster_name}-cluster-to-other-project-db"
#   network = "other-network"
#   allow {
#     protocol = "icmp"
#   }
#   allow {
#     protocol = "tcp"
#     ports    = ["5432"]
#   }
#   source_ranges = ["${var.subnet_cidr}", "${var.pod_range}"]
#   target_tags = ["network-tag-name"]
# }



# All the network elements we’ve added so far included internal IP addresses. The safest way to get out of 
# the internal network is to use a Nat gateway. Here, we will use Cloud Nat and Cloud Router services of GC and 
# allocate public IP address first.

resource "google_compute_address" "project-nat-ips" {
  count = var.cloud_nat_ips
  # name    = element(values(var.cloud_nat_ips), count.index)
  name    = "${var.vpc_name}-public-ip-${count.index}"
  project = var.gcp_project
  region  = var.region
}

# Finally, the VPC element in the network section is VPC peering. VPC networks can communicate in private 
# with your other VPC networks of GC projects using the VPC Peering. We can imagine that it creates an encrypted 
# tunnel in between. We will create a VPC Peering element so that the relevant VPC network can communicate with 
# the VPC networks or networks in another project.

# resource "google_compute_network_peering" "vpc_peerings" {
#   count = "${length(var.vpc_peerings)}"
#   name         = "${element(keys(var.vpc_peerings), count.index)}"
#   network      = "${google_compute_network.project-network.self_link}"
#   peer_network = "${element(values(var.vpc_peerings), count.index)}"
# }

resource "google_compute_router" "project-router" {
  name = "${var.vpc_name}-nat-router"
  # network = "${google_compute_network.project-network.self_link}"  # TODO:  add network name using variable
  network = google_compute_network.project-network.self_link

  # tags = merge(
  #   var.default_tags,
  #   {
  #     Name = "${var.default_tag}-comput-router"
  #   }
  # )
}

resource "google_compute_router_nat" "project-nat" {
  name                   = "${var.vpc_name}-nat-gw"
  router                 = google_compute_router.project-router.name
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.project-nat-ips.*.self_link # TODO: add value of nat from node folder
  #   nat_ips = [var.nat_ips]  # TODO: add value of nat from node folder
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  depends_on                         = [google_compute_address.project-nat-ips] # TODO: link this to the public ip address for the project
  # subnetwork {
  #   name                    = google_compute_subnetwork.project-subnet.id
  #   source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  # }

  # tags = merge(
  #   var.default_tags,
  #   {
  #     Name = "${var.project_tag}-compute-router-nat"
  #   }
  # )

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
