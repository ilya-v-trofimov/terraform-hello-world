provider "aws" {
  region = "${var.region}"
  version = "1.52"
}

terraform {
  backend "s3" {
    bucket = "terraform-bbl-state"
    key = "iltr/alb/bbl.tfstate"
    region = "ap-southeast-2"
  }
}

locals {
  alb_name = "terraform-bbl-alb-${var.octo_user_id}"
  tg_name = "terraform-bbl-tg-${var.octo_user_id}"
  listener_name = "terraform-bbl-listener${var.octo_user_id}"
}

resource "aws_alb" "alb" {
  name = "${local.alb_name}"
  internal = true
  load_balancer_type = "application"
  subnets = "${var.subnet_ids}"
  tags = "${var.tags}"
}

resource "aws_alb_target_group" "alb_tg" {
  name = "${local.tg_name}"
  tags = "${var.tags}"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"

  health_check {
    path = "/"
    port = "80"
    matcher = "200"
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_tg.arn}"
    type = "forward"
  }
}