variable "region" {}

variable "terraform_state_bucket" {}

variable "vpc_id" {}

variable "user_id" {}

variable "tags" {
  type = map(any)
}
