resource "google_artifact_registry_repository" "default" {
  provider = google-beta

  repository_id = var.repository_id
  format        = "DOCKER"
  mode          = "STANDARD_REPOSITORY"

  location     = var.location
  description  = var.repository_description
  labels       = var.labels
  kms_key_name = var.kms_key_name
  project      = var.project

  docker_config {
    immutable_tags = var.immutable_tags
  }
}

resource "google_artifact_registry_repository_iam_member" "readers" {
  for_each = { for reader in var.readers : reader => reader }

  provider = google-beta

  project    = google_artifact_registry_repository.default.project
  location   = google_artifact_registry_repository.default.location
  repository = google_artifact_registry_repository.default.name
  role       = "roles/artifactregistry.reader"
  member     = each.key
}

resource "google_artifact_registry_repository_iam_member" "writers" {
  for_each = { for writer in var.writers : writer => writer }

  provider = google-beta

  project    = google_artifact_registry_repository.default.project
  location   = google_artifact_registry_repository.default.location
  repository = google_artifact_registry_repository.default.name
  role       = "roles/artifactregistry.writer"
  member     = each.key
}
