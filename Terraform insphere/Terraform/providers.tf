
provider "aws" {
  region = var.region
  # region = "ap-south-1"
  # access_key = "AKIA563Y5ZQBHWSBNYW4"
  # secret_key = "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"
  # region = var.region
}

# terraform {
#   backend "s3" {
#     # bucket = "ispl-terraform"
#     # key    = "terraform/state.tfstate"
#     # region = "ap-south-1"
#     # No locking used
#   }
# }
