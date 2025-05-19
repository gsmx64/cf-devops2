resource "google_project" "default" {
  name                = var.project_name
  project_id          = var.project_id
  auto_create_network = false
  billing_account     = var.billing_account
}

resource "google_project_service" "gcp_services" {
  for_each = toset(var.google_apis)
  project  = var.project_id
  service  = each.key
}

