variable "billing_account" {
  type        = string
  description = "Required for project setup and some other operations"
}

variable "project_id" {
  type        = string
  description = "google project identifier"
}

variable "project_name" {
  type        = string
  description = "Project name in GCP"
}

variable "google_apis" {
  description = "The list of non-standard installed apis necessary for the project"
  type        = list(string)
  default     = []
}

variable "location" {
  type        = string
  default     = "US"
  description = "The GCP location in which to provision resources."
}

variable "region" {
  type        = string
  description = "The region in which to create the infraestructure"
  default     = "us-east1"
}

variable "zone" {
  type        = string
  description = "The zone in which to create the infraestructure"
  default     = "us-east1-a"
}

# Bucket variables
variable "tfstate_filename" {
  type        = string
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = "./backend.tf"
}

variable "tfstate_remote_bucket_intro" {
  type = string
  description = "The beginning of the name of the google storage bucket"
  default     = "petclinic-remote-tfstate"
}

variable "tfstate_folder_prefix" {
  type        = string
  description = "The prefix for the folder in the bucket"
  default     = "terraform/state/prod"
}

# Network variables
variable "vpc_name" {
  type        = string
  description = "The Name for vpc"
  default     = "Petclinic-vpc"
}

variable "vpc_subnet" {
  type = string
  default = "10.10.0.0/24"
  description = "Subnet range"
}

# Cloud SQL variables
variable "sql_type_version" {
  type = string
  default = "MYSQL_8_0"
}

variable "authorized_networks" {
  type = string
  default = "10.10.0.0/23"
  description = "Authorized networks for Cloud SQL"
}

variable "availability_type" {
  type = string
  default = {
    prod = "REGIONAL"
    dev  = "ZONAL"
  }
  description = "Availability type for HA"
}

variable "sql_instance_size" {
  type = string
  default     = "db-f1-micro"
  description = "Size of Cloud SQL instances"
}

variable "sql_disk_type" {
  type = string
  default     = "PD_SSD"
  description = "Cloud SQL instance disk type"
}

variable "sql_disk_size" {
  type = string
  default     = "10"
  description = "Storage size in GB"
}

variable "sql_master_zone" {
  default     = "a"
  description = "Zone of the Cloud SQL master (a, b, ...)"
}

variable "sql_replica_zone" {
  type = string
  default     = "b"
  description = "Zone of the Cloud SQL replica (a, b, ...)"
}

variable "sql_connect_retry_interval" {
  type = number
  default     = 60
  description = "The number of seconds between connect retries."
}

variable "sql_name" {
  default = "petclinic"
  description = "The name of the SQL Database instance"
}

variable "sql_user" {
  type = string
  default     = "petclinic"
  description = "Username of the host to access the database"
}

variable "sql_password" {
  type = string
  description = "Password of the host to access the database"
}

# Registry variables
variable "repository_id" {
  description = "The last part of the repository name, for example: 'repo1'."
  type        = string
  default     = "petclinic-repo-dev"
}

variable "repository_description" {
  description = "The description of the repository."
  type        = string
  default     = "Petclinic repsitory"
}

# GKE variables
variable "billing_account" {
  type        = string
  description = "Required for project setup and some other operations"
}

variable "gke_serviceaccount" {
  type        = string
  default     = "gke-svcacct-poccluster"
  description = "Compute service account for GKE"
}

variable allowed_ssh_ips {
  type = string
  description = "IPs allowed to access a bastian host to reach the control plane"
}

variable public_subnet_range {
  type = string
  description = "The IPs to assign to the public subnet, which will host the jump host"
}

variable public_subnet_name {
  type = string
  description = "The name of the public subnet, which will host the jump host"
}