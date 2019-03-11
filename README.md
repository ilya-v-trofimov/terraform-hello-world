# Terraform Hello World
Creates a AWS S3 bucket
Outputs bucket name
Everything in single file

Commands:
- `terraform init` - inits terraform configuration
- `terraform plan -out=tfplan.out` - creates a plan for the configuration. Outputs plan to `tfplan.out`
- `terraform apply "tfplan.out"` - applies previously created plan
- `terraform destroy` - destroys managed stack