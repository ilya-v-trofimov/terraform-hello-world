region = "ap-southeast-2"

availability_zones = ["ap-southeast-2a","ap-southeast-2b"]

terraform_state_bucket = "terraform-bbl-state"

vpc_id = "vpc-024ec4372f90faa1f"

subnet_ids = ["subnet-0e74055428490c17b", "subnet-0143f2ea38f67be74"]

octo_user_id = "iltr"

ami_id = "ami-0b27aae3ff2e5c923" //Amazon Linux 2 AMI

instance_type = "t2.micro"

iam_role = "terraform-bbl-role"

key_pair_name = "foundation-labs-ec2-iltr" //put your KeyPair name here

tags = {
  event_name = "terraform-bbl",
  date = "13/03/2019"
  description = "Terraform-is-amazing"
}