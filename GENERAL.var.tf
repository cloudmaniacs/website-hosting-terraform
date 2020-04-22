#### GENERAL
variable "project_account_id" {
  default = "657244975541"
}

variable "project_name" {
  default = "cloudmaniacs"
}

variable "environment" {
  default = "demo"
}

variable "region" {
  default = "eu-central-1"
}

variable "availability_zone" {
  default = {
    "0" = "eu-central-1a"
    "1" = "eu-central-1b"
    "2" = "eu-central-1c"
  }
}