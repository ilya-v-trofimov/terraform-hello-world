terraform {
  backend "s3" {
    bucket = "terraform-resmed-lab-state"
    key = "<user_id>/alb/lab.tfstate" //TODO
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
  region = "<TODO>"//TODO: populate missing values (use variables)
}

locals {
  alb_name = "terraform-lab-alb-${var.user_id}"
  tg_name = "terraform-lab-tg-${var.user_id}"
  listener_name = "terraform-lab-listener${var.user_id}"
}

resource "aws_alb" "alb" {
  name = "<TODO>"//TODO: use local alb name
  internal = false
  load_balancer_type = "application"
  subnets = "<TODO>" //TODO use subnet_ids variable (see variables.tf)
  tags = "<TODO>"//TODO: populate missing values
}

resource "aws_alb_target_group" "alb_tg" {
  name = "<TODO>"//TODO: use local target group name
  tags = "<TODO>"//TODO: populate missing values
  port = "80"
  protocol = "HTTP"
  vpc_id = "<TODO>"//TODO: populate missing values

  //TODO: add a health check configuration with parameters: path = "/", port = 80, matcher = "200"

}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "<TODO>"//TODO: populate missing values
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = "<TODO>"//TODO: populate missing values
    type = "forward"
  }
}
