terraform {
  backend "local" {
    path = "terraform/state/prod/terraform.tfstate"
  }
}
