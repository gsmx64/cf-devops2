variable "billing_account" {
  type        = string
  description = "Required for project setup and some other operations"
}

variable "project_id" {
  type        = string
  description = "The ID of the project that is created via terraform"
}

variable "vpc_name" {
  type        = string
  description = "Identifier of the VPC network"
  default     = "default-vpc"
}

variable "vpc_subnet" {
  type        = string
  description = "Subnet name we'll use for GKE"
}

variable "region" {
  description = "The region in which to create the GKE cluster"
}

variable "gke_serviceaccount" {
  description = "Compute service account for GKE"
  type        = string
  default     = "gke-svcacct-poccluster"
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
