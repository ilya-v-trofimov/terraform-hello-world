region = "us-west-2"

availability_zones = [
  "us-west-2a",
  "us-west-2b"]

terraform_state_bucket = "terraform-lab-state"

vpc_id = "ami-0721c9af7b9b75114"

subnet_ids = [
  "subnet-0a4c2ad0f5420bf4c",
  "subnet-019dae4e25b36f8a2"]

user_id = "ilya"

ami_id = "ami-0ab4d1e9cf9a1215a" //Amazon Linux 2 AMI

instance_type = "t2.micro"

iam_role = "terraform-lab-role"

key_pair_name = "foundation-labs-ec2-ilya" //put your KeyPair name here

tags = {
  event_name = "terraform-lab",
  date = "29/06/2021"
  description = "Terraform-is-amazing"
}
