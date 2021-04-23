terraform {
  required_version = ">= 0.15.0"
}

provider "google" {
  project = local.project
  region  = local.region
}