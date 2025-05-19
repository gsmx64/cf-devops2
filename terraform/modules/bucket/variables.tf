variable "location" {
  type        = string
  description = "The GCP location in which to provision resources."
}

variable "tfstate_filename" {
  type        = string
  description = "The local path of the file to store the terraform state"
}

variable "tfstate_remote_bucket_intro" {
  type        = string
  description = "The beginning of the name of the google storage bucket"
}

variable "tfstate_folder_prefix" {
  type        = string
  description = "The prefix for the folder in the bucket"
}
