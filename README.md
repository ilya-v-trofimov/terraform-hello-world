# Terraform hands-on exercise
## Prerequisites:
* Download terraform from: https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_darwin_amd64.zip
* Unzip terraform_0.11.13_darwin_amd64.zip
* Move to /usr/local/bin/terraform
* Make sure you've got AWS credentials in `~/.aws/credentials`, `default` profile 
## Running terraform:
For each of the layers use following commands:
- `cd <layer_directory>`
- `terraform init -var-file=../vars/dev.tfvars` - inits terraform configuration
- `terraform plan -var-file=../vars/dev.tfvars -out=tfplan.out` - creates a plan for the configuration. Outputs plan to `tfplan.out`
- `terraform apply "tfplan.out"` - applies previously created plan
- `terraform destroy -var-file=../vars/dev.tfvars` - destroys managed stack