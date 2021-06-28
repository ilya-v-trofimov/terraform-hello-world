terraform {
  backend "s3" {
    bucket = "terraform-resmed-lab-state"
    key = "ilya/alb/lab.tfstate"
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
  alb_name = "terraform-lab-alb-${var.user_id}"
  tg_name = "terraform-lab-tg-${var.user_id}"
  listener_name = "terraform-lab-listener${var.user_id}"
}

resource "aws_alb" "alb" {
  name = local.alb_name
  internal = true
  load_balancer_type = "application"
  subnets = var.subnet_ids
  tags = var.tags
}

resource "aws_alb_target_group" "alb_tg" {
  name = local.tg_name
  tags = var.tags
  port = "80"
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    path = "/"
    port = "80"
    matcher = "200"
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_tg.arn
    type = "forward"
  }
}
