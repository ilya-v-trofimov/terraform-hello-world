provider "aws" {
  region = var.region
  version = "3.47.0"
}

terraform {
  backend "s3" {
    bucket = "terraform-lab-state"
    key = "ilya/autoscaling/lab.tfstate"
    region = "us-west-2"
  }
}

locals {
  launch_config_name = "terraform-lab-lc-${var.user_id}"
  asg_name = "terraform-lab-asg-${var.user_id}"
}

data "terraform_remote_state" "security" {
  backend = "s3"
  workspace = terraform.workspace

  config {
    bucket = var.terraform_state_bucket
    key = "${var.user_id}/security/lab.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  workspace = terraform.workspace

  config {
    bucket = var.terraform_state_bucket
    key = "${var.user_id}/alb/lab.tfstate"
    region = var.region
  }
}

resource "aws_launch_configuration" "launch_config" {
  name = local.launch_config_name
  image_id = var.ami_id
  instance_type = var.instance_type
  iam_instance_profile = var.iam_role
  key_name = var.key_pair_name
  security_groups = [
    data.terraform_remote_state.security.security_group_id]
  user_data = templatefile("${path.module}/templates/user_data.template", {
    user_id = var.user_id
  })
  associate_public_ip_address = true
}

resource "aws_autoscaling_group" "asg" {
  name = local.asg_name
  availability_zones = var.availability_zones
  desired_capacity = "1"
  max_size = "1"
  min_size = "1"
  vpc_zone_identifier = var.subnet_ids
  launch_configuration = aws_launch_configuration.launch_config.id
  target_group_arns = [
    data.terraform_remote_state.alb.alb_tg]
  tags = [
    data.null_data_source.asg_tags.*.outputs]
}

data "null_data_source" "asg_tags" {
  count = length(keys(var.tags))

  inputs = {
    key = element(keys(var.tags), count.index)
    value = element(values(var.tags), count.index)
    propagate_at_launch = true
  }
}