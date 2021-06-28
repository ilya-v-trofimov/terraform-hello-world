terraform {
  backend "s3" {
    bucket = "terraform-resmed-lab-state"
    key = "ilya/autoscaling/lab.tfstate"
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
  region = "<TODO>"//TODO: populate missing values
}

locals {
  launch_config_name = "terraform-lab-lc-${var.user_id}"
  asg_name = "terraform-lab-asg-${var.user_id}"
}

data "terraform_remote_state" "security" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = var.terraform_state_bucket
    key = "${var.user_id}/security/lab.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  workspace = terraform.workspace

  config = {
    bucket = var.terraform_state_bucket
    key = "${var.user_id}/alb/lab.tfstate"
    region = var.region
  }
}

resource "aws_launch_configuration" "launch_config" {
  name = "<TODO>"//TODO: populate missing values (use local vars)
  image_id = "<TODO>"//TODO: populate missing values
  instance_type = "<TODO>"//TODO: populate missing values
  iam_instance_profile = "<TODO>"//TODO: populate missing values
  key_name = "<TODO>"//TODO: populate missing values
  security_groups = [
    "<TODO>"//TODO: populate missing values (use one of the data sources)
  ]
  user_data = "<TODO>"//TODO: populate missing values (use templatefile function)
  associate_public_ip_address = true
}

resource "aws_autoscaling_group" "asg" {
  name = "<TODO>"//TODO: populate missing values
  availability_zones = "<TODO>"//TODO: populate missing values
  desired_capacity = "1"
  max_size = "1"
  min_size = "1"
  launch_configuration = "<TODO>"//TODO: populate missing values
  target_group_arns = [
    "<TODO>"//TODO: populate missing values (use one of the data sources)
  ]

  dynamic "tag" {
    for_each = "<TODO>" //TODO: populate missing values
    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = true
    }
  }
}
