variable "region" {
  type = string
  description = "The Region of resources"
}

variable "vpc_name" {
  type = string
  description = "The Network name"
}

variable "subnet_cidr" {
  type        = "map"
  description = "Subnet range"
}
