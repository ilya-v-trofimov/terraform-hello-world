provider "aws" {
  region = "${var.region}"
  version = "1.52"
}

terraform {
  backend "s3" {
    bucket = "terraform-bbl-state"
    key = "iltr/security/bbl.tfstate"
    region = "ap-southeast-2"
  }
}

locals {
  security_group_name = "terraform_bbl_sg_${var.octo_user_id}"
}

resource "aws_security_group" "this_security_group" {
  name = "${local.security_group_name}"
  vpc_id = "${var.vpc_id}"

  revoke_rules_on_delete = true
  tags = "${var.tags}"
}

resource "aws_security_group_rule" "ingress" {
  security_group_id = "${aws_security_group.this_security_group.id}"
  type = "ingress"

  cidr_blocks = ["0.0.0.0/0"]

  from_port = "-1"
  to_port = "-1"
  protocol = "all"
}

resource "aws_security_group_rule" "egress" {
  security_group_id = "${aws_security_group.this_security_group.id}"
  type = "egress"

  cidr_blocks = ["0.0.0.0/0"]

  from_port = "-1"
  to_port = "-1"
  protocol = "all"
}
