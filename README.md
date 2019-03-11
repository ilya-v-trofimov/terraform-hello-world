# Terraform Hello World
Creates a AWS S3 bucket
Outputs bucket name

Commands:
- `terraform init` - inits terraform configuration
- `terraform plan -var-file=vars/dev.tfvars -out=tfplan.out` - creates a plan for the configuration. Outputs plan to `tfplan.out`
- `terraform apply "tfplan.out"` - applies previously created plan
- `terraform destroy -var-file=vars/dev.tfvars` - destroys managed stack