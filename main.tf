provider "aws" {
  region = var.region
  version = "3.47.0"
}

terraform {
  backend "local" {}
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}
