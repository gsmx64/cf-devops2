terraform {
  backend "local" {
    path = "terraform/state/dev/terraform.tfstate"
  }
}
