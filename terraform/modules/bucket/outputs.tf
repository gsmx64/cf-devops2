output "name" {
  value       = "${google_storage_bucket.my_bucket.name}"
  description = "The bucket name fr tf remte state"
}
