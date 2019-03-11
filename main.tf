provider "aws" {
  region = "${var.region}"
  version = "1.52"
}

terraform {
  backend "local" {}
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
}