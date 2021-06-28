# Terraform hands-on exercise
## Prerequisites:
* Install Terraform CLI from https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform
* Make sure you've got AWS credentials in `~/.aws/credentials`, `default` profile
## Running terraform:
For each of the layers use following commands:
- `cd <layer_directory>`
- `terraform init` - inits terraform configuration
- `terraform plan -var-file=../vars/dev.tfvars -out=tfplan.out` - creates a plan for the configuration. Outputs plan to `tfplan.out`
- `terraform apply "tfplan.out"` - applies previously created plan
- `terraform destroy -var-file=../vars/dev.tfvars` - destroys managed stack
