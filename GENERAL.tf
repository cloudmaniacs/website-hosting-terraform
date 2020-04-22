provider "aws" {
  region = var.region
}

### Provider for CDN Certificates
provider "aws" {
  alias = "virginia"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "cloudmaniacs-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}