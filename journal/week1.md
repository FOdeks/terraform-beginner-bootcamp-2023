# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

The root module structure is set up as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```
Note: ChatGPT was used to generate the tree structure in ASCII format.

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

We can set two kinds of variables in Terraform Cloud:
- Environment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your `.tfvars` file

We can set variables in Terraform Cloud to be sensitive so they are not visible (i.e. masked) in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the `.tfvars` file e.g.
```
terraform plan -var user_uuid="my-user_id"
```

### var-file flag
We can use the `-var-file` flag to specify a variable file that contains values for our variables e.g. 
```
terraform apply -var-file=my_variables.tfvars
```

### terraform.tfvars
We can use the `terraform.tfvars` file when we want our default variables to be automatically loaded by Terraform. This file must be in the same directory as the Terraform configuration files. We don't need to specify this file explicitly when running Terraform commands. 

### *.auto.tfvars
We can use the `*.auto.tfvars` files to automatically load default variable values without explicitly specifying them when running Terraform commands. These files are particularly useful when you want to manage variable values for different workspaces e.g. development, staging and production environments
```
dev.auto.tfvars
staging.auto.tfvars
prod.auto.tfvars
```
In each *.auto.tfvars file, we can define variable values specific to the respective workspace.

For example, if you set your Terraform workspace to `dev`, Terraform will load `dev.auto.tfvars` and use the values from that file for your variables:
```
terraform workspace select dev
terraform apply
```
If you switch to a different workspace, Terraform will load the corresponding `*.auto.tfvars` file for that workspace.

### Order of Terraform Variables

- TODO: document which terraform variables takes precedence.
