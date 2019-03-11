provider "aws" {
  region = "ap-southeast-2"
  version = "1.52"
}

terraform {
  backend "local" {}
}

resource "aws_s3_bucket" "bucket" {
  bucket = "iltr-terraform-test-bucket"
}

output "bucket_name" {
  value = "${aws_s3_bucket.bucket.id}"
}