variable "repository_id" {
  description = "(Required) The last part of the repository name, for example: 'repo1'."
  type        = string
}

variable "location" {
  description = "(Optional) The name of the location this repository is located in."
  type        = string
  default     = null
}

variable "repository_description" {
  description = "(Optional) The user-provided description of the repository."
  type        = string
  default     = null
}

variable "labels" {
  description = "(Optional) Labels with user-defined metadata. This field may contain up to 64 entries. Label keys and values may be no longer than 63 characters. Label keys must begin with a lowercase letter and may only contain lowercase letters, numeric characters, underscores, and dashes."
  type        = map(string)
  default     = {}
}

variable "kms_key_name" {
  description = "(Optional) The Cloud KMS resource name of the customer managed encryption key that’s used to encrypt the contents of the Repository. Has the form: `projects/my-project/locations/my-region/keyRings/my-kr/cryptoKeys/my-key`. This value may not be changed after the Repository has been created."
  type        = string
  default     = null
}

variable "project" {
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "immutable_tags" {
  type        = bool
  description = "(Optional) The repository which enabled this flag prevents all tags from being modified, moved or deleted. This does not prevent tags from being created. Defaults to `true`."
  default     = true
}

variable "readers" {
  type        = list(string)
  description = <<EOF
(Optional) Identities that will be granted the read privilege in role. Each entry can have one of the following values:

- allUsers: A special identifier that represents anyone who is on the internet; with or without a Google account.
- allAuthenticatedUsers: A special identifier that represents anyone who is authenticated with a Google account or a service account.
- user:{emailid}: An email address that represents a specific Google account. For example, alice@gmail.com or joe@example.com.
- serviceAccount:{emailid}: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
- group:{emailid}: An email address that represents a Google group. For example, admins@example.com.
- domain:{domain}: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.
- projectOwner:projectid: Owners of the given project. For example, "projectOwner:my-example-project"
- projectEditor:projectid: Editors of the given project. For example, "projectEditor:my-example-project"
- projectViewer:projectid: Viewers of the given project. For example, "projectViewer:my-example-project"
EOF
  default     = []
}

variable "writers" {
  type        = list(string)
  description = <<EOF
(Optional) Identities that will be granted the write privilege in role. Each entry can have one of the following values:

- allUsers: A special identifier that represents anyone who is on the internet; with or without a Google account.
- allAuthenticatedUsers: A special identifier that represents anyone who is authenticated with a Google account or a service account.
- user:{emailid}: An email address that represents a specific Google account. For example, alice@gmail.com or joe@example.com.
- serviceAccount:{emailid}: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
- group:{emailid}: An email address that represents a Google group. For example, admins@example.com.
- domain:{domain}: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.
- projectOwner:projectid: Owners of the given project. For example, "projectOwner:my-example-project"
- projectEditor:projectid: Editors of the given project. For example, "projectEditor:my-example-project"
- projectViewer:projectid: Viewers of the given project. For example, "projectViewer:my-example-project"
EOF
  default     = []
}
