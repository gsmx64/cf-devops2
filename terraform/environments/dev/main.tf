# Configure the Google Cloud provider

module "bucket" {
  source = "../../modules/bucket"
  tfstate_filename = var.tfstate_filename
  tfstate_remote_bucket_intro = var.tfstate_remote_bucket_intro
  tfstate_folder_prefix = var.tfstate_folder_prefix
  location = var.region
}

module "project" {
  source          = "../../modules/project"
  billing_account = var.billing_account
  project_id      = var.project_id
  project_name    = var.project_name
  google_apis     = var.google_apis
}

module "vpc" {
  source = "../../modules/vpc"
  vpc_name = "${module.vpc_name}-${terraform.workspace}"
  auto_create_subnetworks = "${module.auto_create_subnetworks}"
}

module "subnet" {
  source      = "../../modules/subnet"
  region      = "${var.region}"
  vpc_name    = "${module.vpc.vpc_name}"
  subnet_cidr = "${var.vpc_subnet}"
}

module "firewall" {
  source        = "../../modules/firewall"
  depends_on = [
    module.project,
    module.vpc
  ]
  project_id = var.project_id
  vpc_name = var.vpc_name
  public_subnet_name = var.public_subnet_name
  public_subnet_range = var.public_subnet_range
  allowed_ssh_ips = var.allowed_ssh_ips
  vpc_subnet = var.vpc_subnet
}

module "cloudsql" {
  source                     = "../../modules/cloudsql"
  region                     = "${var.region}"
  availability_type          = "${var.availability_type}"
  sql_instance_size          = "${var.sql_instance_size}"
  sql_disk_type              = "${var.sql_disk_type}"
  sql_disk_size              = "${var.sql_disk_size}"
  sql_master_zone            = "${var.sql_master_zone}"
  sql_connect_retry_interval = "${var.sql_connect_retry_interval}"
  sql_replica_zone           = "${var.sql_replica_zone}"
  sql_name                   = "${var.sql_name}-${terraform.workspace}"
  sql_user                   = "${var.sql_user}"
  sql_password               = "${var.sql_password}"
}

module "registry" {
  source                   = "../../modules/registry"
  location                 = "${var.region}"
  repository_id            = "${var.repository_id}"
  repository_description   = "${var.repository_description}"
}

module "gke" {
  source = "../../modules/gke"
  depends_on = [ 
    module.project,
    module.vpc,
    module.firewall_rules
  ]
  project_id         = var.project_id
  billing_account    = var.billing_account
  region             = var.region
  vpc_name           = var.vpc_name
  vpc_subnet         = var.vpc_subnet
  gke_serviceaccount = var.gke_serviceaccount
  public_subnet_name = var.public_subnet_name
  public_subnet_range = var.public_subnet_range
  allowed_ssh_ips = var.allowed_ssh_ips
}

module "argocd" {
  source                   = "../../modules/argocd"
  project_id            = "${var.project_id}"
}
