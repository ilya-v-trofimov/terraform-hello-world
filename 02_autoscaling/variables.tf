variable "region" {}

variable "terraform_state_bucket" {}

variable "vpc_id" {}

variable "subnet_ids" {
  type = list(string)
}

variable "user_id" {}

variable "ami_id" {}

variable "instance_type" {}

variable "instance_profile" {}

variable "key_pair_name" {}

variable "availability_zones" {
  type = list(string)
}

variable "tags" {
  type = map(any)
}
