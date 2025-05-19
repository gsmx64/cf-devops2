variable "google_apis" {
  type        = list(string)
  description = "The list of non-standard installed apis necessary for the project"
  default     = []
}

variable "project_id" {
  type        = string
  description = "google project identifier"
}

variable "project_name" {
  type        = string
  description = "Project name in GCP"
}

variable "billing_account" {
  type        = string
  description = "GCP billing account associatd with the project"
}
