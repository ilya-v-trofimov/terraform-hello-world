provider "aws" {
  region = "${var.region}"
  version = "1.52"
}

terraform {
  backend "s3" {
    bucket = "terraform-bbl-state"
    key = "iltr/autoscaling/bbl.tfstate"
    region = "ap-southeast-2"
  }
}


locals {
  launch_config_name = "terraform-bbl-lc-${var.octo_user_id}"
  asg_name = "terraform-bbl-asg-${var.octo_user_id}"
}


data "terraform_remote_state" "security" {
  backend = "s3"
  workspace = "${terraform.workspace}"

  config {
    bucket = "${var.terraform_state_bucket}"
    key = "${var.octo_user_id}/security/bbl.tfstate"
    region = "${var.region}"
  }
}


data "terraform_remote_state" "alb" {
  backend = "s3"
  workspace = "${terraform.workspace}"

  config {
    bucket = "${var.terraform_state_bucket}"
    key = "${var.octo_user_id}/alb/bbl.tfstate"
    region = "${var.region}"
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.template")}"
  vars {
    octo_user_id = "${var.octo_user_id}"
  }
}

resource "aws_launch_configuration" "launch_config" {
  name = "${local.launch_config_name}"
  image_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_role}"
  key_name = "${var.key_pair_name}"
  security_groups = ["${data.terraform_remote_state.security.security_group_id}"]
  user_data = "${data.template_file.user_data.rendered}"
  associate_public_ip_address = true
}

resource "aws_autoscaling_group" "asg" {
  name = "${local.asg_name}"
  availability_zones = "${var.availability_zones}"
  desired_capacity   = "1"
  max_size           = "1"
  min_size           = "1"
  vpc_zone_identifier = "${var.subnet_ids}"
  launch_configuration = "${aws_launch_configuration.launch_config.id}"
  target_group_arns = ["${data.terraform_remote_state.alb.alb_tg}"]
  tags = ["${data.null_data_source.asg_tags.*.outputs}"]
}

data "null_data_source" "asg_tags" {
  count = "${length(keys(var.tags))}"

  inputs = {
    key                 = "${element(keys(var.tags), count.index)}"
    value               = "${element(values(var.tags), count.index)}"
    propagate_at_launch = true
  }
}
