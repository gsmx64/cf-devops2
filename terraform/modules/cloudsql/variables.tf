variable "region" {
  type = string
  description = "Region of resources"
}

# Cloud SQL variables
variable "sql_type_version" {
  type = string
  default = "MYSQL_8_0"
  description = "Cloud SQL type and version"
}

variable "authorized_networks" {
  type = string
  default = "0.0.0.0/0"
  description = "Authorized networks for Cloud SQL"
}

variable "availability_type" {
  type        = "map"
  description = "Availability type for HA"
}

variable "sql_instance_size" {
  type = string
  description = "Size of Cloud SQL instances"
}

variable "sql_disk_type" {
  type = string
  description = "Cloud SQL instance disk type"
}

variable "sql_disk_size" {
  type = string
  description = "Storage size in GB"
}

variable "sql_connect_retry_interval" {
  type = string
  description = "The number of seconds between connect retries."
}

variable "sql_master_zone" {
  type = string
  description = "Zone of the Cloud SQL master (a, b, ...)"
}

variable "sql_replica_zone" {
  type = string
  description = "Zone of the Cloud SQL replica (a, b, ...)"
}

variable "sql_name" {
  type = string
  description = "The name of the SQL Database instance"
}

variable "sql_user" {
  type = string
  description = "The username of the host to access the database"
}

variable "sql_password" {
  type = string
  description = "The password of the host to access the database"
}
