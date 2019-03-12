variable "region" {}

variable "terraform_state_bucket" {}

variable "vpc_id" {}

variable "subnet_id" {}

variable "octo_user_id" {}

variable "ami_id" {}

variable "instance_type" {}

variable "iam_role" {}

variable "key_pair_name" {}

variable "availability_zones" {
  type = "list"
}

variable "tags" {
  type = "map"
}