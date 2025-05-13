
terraform {
  backend "s3" {
    bucket = "ispl-terraform"
    key    = "terraform/state.tfstate"
    region = "ap-south-1"
  }
}
