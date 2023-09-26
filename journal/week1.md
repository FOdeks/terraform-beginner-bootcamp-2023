# Terraform Beginner Bootcamp 2023 - Week 1
## Building Terrahouse

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
```sh
terraform plan -var user_uuid="my-user_id"
```

### var-file flag
We can use the `-var-file` flag to specify a variable file that contains values for our variables e.g. 
```sh
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
```sh
terraform workspace select dev
terraform apply
```
If you switch to a different workspace, Terraform will load the corresponding `*.auto.tfvars` file for that workspace.

### Order of Terraform Variables

- TODO: document which terraform variables takes precedence.

## Dealing With Configuration Drift

## What happens if we lose our State file?

If you lose your state file, you will most likley have to destroy all your cloud infrastructure manually.

You can use terraform import but it may not work for all cloud resources. You need to check the Terraform Registry providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

```sh
terraform import aws_s3_bucket.bucket bucket_name
```

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone mistakenly deletes or modifies cloud resource manually through ClickOps, if we run `terraform plan` again, it will attempt to put our infrastructure back into the expected state by fixing Configuration Drift.


### Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the Terraform variables in its own `variables.tf`.

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```


[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform code

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples (or code) for providers that could be deprecated.

## Working with Files in Terraform


### fileexists function

This is a built in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### filemd5
TODO - description


https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


```tf
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = "${path.root}/public/error.html"

  etag = filemd5(var.error_html_filepath)
}
```


