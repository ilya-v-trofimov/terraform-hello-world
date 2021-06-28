terraform {
  backend "s3" {
    bucket = "terraform-resmed-lab-state"
    key = "<user_id>/security/lab.tfstate" //TODO
    region = "us-west-2"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.47.0"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  security_group_name = "terraform-lab-sg-${var.user_id}"
}

resource "aws_security_group" "this_security_group" {
  name = "<TODO>"//TODO: put local security group name here. Access local variable using 'local.var_name'
  vpc_id = var.vpc_id

  revoke_rules_on_delete = true
  tags = var.tags
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = "<TODO>"//TODO: populate missing values
  type = "ingress"

  cidr_blocks = [
    "0.0.0.0/0"]

  from_port = "-1"
  to_port = "-1"
  protocol = "all"
}

resource "aws_security_group_rule" "egress" {
  security_group_id = "<TODO>"//TODO: populate missing values
  type = "egress"

  cidr_blocks = [
    "0.0.0.0/0"]

  from_port = "-1"
  to_port = "-1"
  protocol = "all"
}
