# Terraform hands-on exercise
To run terraform:
1. Download terraform from: https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_darwin_amd64.zip
2. Unzip terraform_0.11.13_darwin_amd64.zip
3. Move to /usr/local/bin/terraform
4. Run commands:
- `cd <layer_directory>`
- `terraform init -var-file=../vars/dev.tfvars` - inits terraform configuration
- `terraform workspace create <YOUR_OCTO_USER_ID>`
- `terraform workspace select <YOUR_OCTO_USER_ID>`
- `terraform plan -var-file=vars/dev.tfvars -out=tfplan.out` - creates a plan for the configuration. Outputs plan to `tfplan.out`
- `terraform apply "tfplan.out"` - applies previously created plan
- `terraform destroy -var-file=vars/dev.tfvars` - destroys managed stack