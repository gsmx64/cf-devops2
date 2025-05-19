resource "google_container_cluster" "primary" {
  name                    = "private-gke-cluster-hybrid-premptible"
  location                = var.region
  enable_kubernetes_alpha = false

  network_policy {
    enabled = true
  }

  resource_labels = {
    environment = "dev"
    team        = "myteam"
  }

  release_channel {
    channel = "REGULAR"
  }

  monitoring_config {
    enable_components = []
  }

  logging_config {
    enable_components = []
  }

  network    = var.vpc_name
  subnetwork = var.vpc_subnet
  deletion_protection = false

  remove_default_node_pool = false

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/8"
      display_name = "vpc-access"
    }
    cidr_blocks { 
        cidr_block = var.public_subnet_range
        display_name = var.public_subnet_name
    }
  }

  node_pool {
    name               = "default-node-pool"
    initial_node_count = 0

    management {
      auto_upgrade = true
    }
    autoscaling {
      total_min_node_count = 1
      total_max_node_count = 3
    }

    node_config {
      machine_type = "e2-medium" #2 shared vCPU up to 100%, 4GB memory
      disk_size_gb = 20
      disk_type    = "pd-ssd"
      tags         = ["dedicated", "pd-ssd", "e2-medium"]
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
      ]
    }
  }
}

resource "google_container_node_pool" "pool-spot-e2" {
  cluster            = google_container_cluster.primary.name
  location           = google_container_cluster.primary.location
  name               = "np-spot-e2-small"
  initial_node_count = 1

  ## optionally, add an include list of zones for the additional nodepool (not tested yet)
  ## with the flag remove_default_node_pool = true, you would be able to have this nodepool replace the one created upon provisioning
  ## and by setting initial_node_count, total_min_node_count + total_max_node_count you get more granular control of both the number of nodes in the nodepool
  ## and where they are placed  e.g., 4 nodes total split across 2 zones within the 1 region, excluding a "bad" zone

  # node_locations = [
  #   "us-central1-c", #zones not regions
  # ]

  management {
    auto_upgrade = true
  }

  autoscaling {
    total_min_node_count = 1
    total_max_node_count = 3
  }

  node_config {
    spot         = true
    machine_type = "e2-small"
    disk_size_gb = 15
    disk_type    = "pd-balanced"
    tags         = ["spot", "pd-balanced", "e2-small"]
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}


resource "google_container_node_pool" "pool-preemptible-n4-standard-2" {
  cluster            = google_container_cluster.primary.name
  location           = google_container_cluster.primary.location
  name               = "np-preemptible-n4-standard-2"
  initial_node_count = 0

  management {
    auto_upgrade = true
  }

  autoscaling {
    total_min_node_count = 0
    total_max_node_count = 2
  }

  node_config {
    preemptible  = true
    machine_type = "n4-standard-2"
    disk_size_gb = 15
    tags         = ["preemptible", "hyperdisk-balanced", "n4-standard-2"]
    disk_type    = "hyperdisk-balanced"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

resource "google_container_node_pool" "pool-spot-n4-standard-2" {
  cluster            = google_container_cluster.primary.name
  location           = google_container_cluster.primary.location
  name               = "np-spot-n4-standard-2"
  initial_node_count = 0

  management {
    auto_upgrade = true
  }

  autoscaling {
    total_min_node_count = 1
    total_max_node_count = 3
  }

  node_config {
    spot         = true
    machine_type = "n4-standard-2"
    disk_size_gb = 15
    tags         = ["spot", "hyperdisk-balanced", "n4-standard-2"]
    disk_type    = "hyperdisk-balanced"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
