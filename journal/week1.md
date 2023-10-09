# Terraform Beginner Bootcamp 2023 - Week 1
## Building Terrahouse

![architecture_diagram_week1](https://github.com/FOdeks/terraform-beginner-bootcamp-2023/assets/99102643/a0ff68f2-c011-4d72-bb6d-f5b667f145ab)

# Table of Contents

- [Fixing Tags](#fixing-tags)
- [Root Module Structure](#root-module-structure)
- [Terraform and Input Variables](#terraform-and-input-variables)
  * [Loading Terraform Input Variables](#loading-terraform-input-variables)
  * [TF_VAR flag](#tf_var-flag)
  * [var flag](#var-flag)
  * [var-file flag](#var-file-flag)
  * [terraform.tfvars](#terraformtfvars)
  * [*.auto.tfvars](#autotfvars)
  * [Order of Precedence for Terraform Variables](#order-of-precedence-for-terraform-variables)
  * [Terraform Cloud Variables](#terraform-cloud-variables)
- [Dealing With Configuration Drift](#dealing-with-configuration-drift)
- [What happens if we lose our State file](#what-happens-if-we-lose-our-state-file)
  * [Fix Missing Resources with Terraform Import](#fix-missing-resources-with-terraform-import)
  * [Fix Manual Configuration](#fix-manual-configuration)
  * [Fix using Terraform Refresh](#fix-using-terraform-refresh)
- [Terraform Modules](#terraform-modules)
  * [Terraform Module Structure](#terraform-module-structure)
  * [Passing Input Variables](#passing-input-variables)
  * [Modules Sources](#modules-sources)
- [Considerations when using ChatGPT to write Terraform code](#considerations-when-using-chatgpt-to-write-terraform-code)
- [Working with Files in Terraform](#working-with-files-in-terraform)
  * [fileexists function](#fileexists-function)
  * [filemd5 function](#filemd5-function)
  * [Path Variable](#path-variable)
- [Terraform Data Sources](#terraform-data-sources)
- [Working with JSON](#working-with-json)
- [Changing the Lifecycle of Resources](#changing-the-lifecycle-of-resources)
- [Terraform Data](#terraform-data)
- [Provisioners](#provisioners)
  * [Local-exec](#local-exec)
  * [Remote-exec](#remote-exec)
- [For Each Expressions](#for-each-expressions)

## Fixing Tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag

```sh
git tag -d <tag_name>
```

Remotely delete a tag

```sh
git push origin --delete <tag_name>
```

Checkout the commit that you want to retag. Grab the **SHA** from your Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

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

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### TF_VAR flag
In Terraform, you can pass environment variables using the TF_VAR_name convention, where name is the name of your variable. Terraform will automatically recognize these environment variables and make them available as variables in your configuration. Here's a simple example:

Suppose you want to pass an environment variable TF_VAR_region to set the AWS region for your Terraform configuration.

Set the environment variable in your terminal session. For example, to set the region to "us-west-2" in a Unix-like shell (Linux or macOS), you can use:

```sh
export TF_VAR_region=us-west-2
```
Create a Terraform configuration (e.g., main.tf) that uses the var.region variable:

```tf
variable "region" {
  description = "AWS region"
}
```tf
provider "aws" {
  region = var.region
}
```
In this example, we define an environment variable named **region** and use it to set the AWS region in the AWS provider block.

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
In each `*.auto.tfvars` file, we can define variable values specific to the respective workspace.

For example, if you set your Terraform workspace to `dev`, Terraform will load `dev.auto.tfvars` and use the values from that file for your variables:
```sh
terraform workspace select dev
terraform apply
```
If you switch to a different workspace, Terraform will load the corresponding `*.auto.tfvars` file for that workspace.

### Order of Precedence for Terraform Variables

Terraform is declarative and aims to determine the desired state of your infrastructure. Variables are just input values that you provide to your configurations, and Terraform calculates the plan based on the values it ultimately resolves. The order of precedence is used to determine which value is assigned to a variable when multiple sources provide values for it.

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

1. Environment variables

2. The `terraform.tfvars` file, if present.

3. The `terraform.tfvars.json` file, if present.

4. Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.

5. Any `-var` and `-var-file` options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

### Tips and Best Practices
1. Use a consistent naming convention for variables and provide descriptive variable descriptions to improve code readability.

2. Store variable declarations in a separate `variables.tf` file.

3. Use reasonable default values for optional variables.

4. Consider using local variables (**Terraform Locals**) and built-in functions to simplify your configurations and perform complex operations.

**Locals** - is used to define local variables. It can be very useful when we need to transform data into another format and we have to reference a variable.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```


```tf
# Define a local variable
locals {
  greeting = "Hello, Terraform!"
}

# Output the local variable value
output "output_greeting" {
  value = local.greeting
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

5. Use validation rules to enforce constraints on variable values.
```tf
variable "menu_item" {
  type        = list(string)
  description = "A list of the items to order from the menu"
  validation {
    condition     = contains(var.menu_item, "thin")
    error_message = "You must order a 'thin' pizza crust since it's our team's favorite"
  }
}
```

6. Mark sensitive variables as such to prevent accidental exposure.
```tf
variable "credit_card" {
  type        = map(string)
  description = "Credit Card Info"
  sensitive   = true
}

# You would need to update the output variable file to look like this:

output "credit_card" {
  value = var.credit_card
  description = "Credit Card Info"
  sensitive = true
}  
```

### Key Takeaways for Working with Terraform Variables

1. Terraform variables are essential for managing large infrastructure configurations and maintaining consistency across environments.

2. Variables can be assigned in various ways, including command-line flags, environment variables, and .tfvars files.

3. Use built-in functions, locals, conditional expressions, and complex data types to create more flexible and powerful configurations.

4. Follow best practices for naming, organizing, and securing your variables to ensure maintainable and secure infrastructure.

### Terraform Cloud Variables

We can set two kinds of variables in **Terraform Cloud**:
- Environment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your `.tfvars` file

We can set variables in Terraform Cloud to be **sensitive** so they are not visible (i.e. masked) in the UI.

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

A Terraform module is a reusable and self-contained collection of Terraform configuration files and resources that can be used to define and manage infrastructure components. It is a fundamental concept in Terraform that promotes modularity, code reusability, and maintainability in Infrastructure as Code (IaC) projects.

Here are some key characteristics and benefits of Terraform modules:

- **Reusability**: Modules allow you to define and package infrastructure components, making them easily reusable across different projects or environments. For example, you could create a module for provisioning a web server, and then use that module in multiple projects to consistently create web servers.

- **Abstraction**: Modules provide a way to abstract complex infrastructure configurations into more manageable and understandable components. This abstraction makes it easier to work with and reason about your infrastructure code.

- **Encapsulation**: Modules encapsulate resources, variables, and other configurations, reducing the chances of conflicts or naming collisions. They also expose a clean interface for users, making it clear how to use the module and what inputs are required.

- **Versioning**: Modules can be versioned, which allows you to control and track changes to your infrastructure code over time. This is especially important when multiple teams or individuals are working on a project.

- **Testing**: Modules can be tested independently of the main infrastructure code. This promotes code quality and reliability by enabling you to validate module behavior before integrating it into your larger infrastructure.

- **Sharing**: Terraform modules can be shared with the community through Terraform Registry or other distribution methods. This encourages collaboration and the development of reusable infrastructure patterns.


### Terraform Module Structure

To create a Terraform module, you typically organize your configuration files, input variables, and resource definitions in a directory structure that follows certain conventions. Then, you can instantiate the module in your **main** Terraform configuration by specifying the module source and providing values for the module's input variables.

Here's an example of how you might use a Terraform module to create an AWS EC2 instance:

```tf
module "ec2_instance" {
  source          = "./modules/ec2"  # Path to the module directory
  instance_count  = 2               # Input variable values for the module
  instance_type   = "t2.micro"
  ami_id          = "ami-0123456789abcdef0"
}
```
- `module` "ec2_instance" is the name you're giving to your module instance. You can choose any name you prefer.
- `source` points to the directory containing the ec2 module. The path can be relative or absolute, depending on your project's structure.
- `instance_count`, `instance_type`, and `ami_id` are input variables that the ec2 module expects. Make sure these variable names match the input variable names defined in the module's variables.tf file.

In this example, the ec2 directory contains the Terraform configuration files and logic for creating the EC2 instances, and the module is instantiated in the main configuration with specific input values.

By using Terraform modules, you can create a more structured, maintainable, and scalable approach to managing your infrastructure code. It is recommended to place modules in a `modules` directory when locally developing modules but you can name it whatever you prefer.

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

Using `source`, we can import the module from various places e.g.:
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

[fileexits](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### filemd5 function

The `filemd5` function is used to calculate the MD5 hash of a file. This can be useful when working with files to verify their integrity or when you need to compare files based on their MD5 checksums. Here's a simple example of how to use the filemd5 function in a Terraform configuration:

```tf
variable "file_path" {
  description = "Path to the file for which you want to calculate the MD5 hash."
  type        = string
  default     = "example.txt" # Update this with the actual path to your file
}

output "md5_checksum" {
  value = filemd5(var.file_path)
}
```

In this example, we define a variable called **file_path**, which represents the path to the file for which we want to calculate the MD5 hash.

We use the `filemd5` function in the output block to calculate the MD5 hash of the file specified by the file_path variable. The resulting MD5 hash is stored in the `md5_checksum` output variable.

**Note:** Before using this configuration, make sure you have the file specified in the file_path variable (in this case, "example.txt") available in the same directory as your Terraform configuration file or provide the correct path to the file.

To apply this configuration, you can use the standard Terraform commands like `terraform init` and `terraform apply`. After running `terraform apply`, you can check the MD5 checksum of the file by inspecting the value of the `md5_checksum` output variable in the Terraform state or by running `terraform output md5_checksum` in the terminal.

The `filemd5` function can be incorporated into more complex configurations or used for tasks like verifying the integrity of downloaded files during infrastructure provisioning.

[filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module

```tf
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = "${path.root}/public/index.html"
}
```
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

## Terraform Data Sources

This allows us to source data from cloud resources. This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON 

We use the ``jsonencode`` function to create the bucket policy (in JSON) inline in the **HCL**. ``jsonencode`` encodes a given value to a string using JSON sytax. 

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```
[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

## Changing the Lifecycle of Resources

[Meta Arguments for Lifcycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in `replace_triggered_by`. You can use `terraform_data`'s behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

```tf
variable "revision" {
  default = 1
}

resource "terraform_data" "replacement" {
  input = var.revision
}

# This resource has no convenient attribute which forces replacement, but can now be replaced by any change to the revision variable value.
resource "example_database" "test" {
  lifecycle {
    replace_triggered_by = [terraform_data.replacement]
  }
}
```
[Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioners

Provisioners allow you to execute commands on compute instances e.g. AWS CLI command. They are not recommended for use by **Hashicorp** because Configuration Management tools such as Ansible are a better fit, but the functionality exists to be used as a last resort. You can use provisioners to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute a command on the machine running the Terraform commands e.g. `terraform plan` and `terraform apply`:

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

### Remote-exec

This will execute commands on a machine which you target. You will need to provide credentials such as `ssh` to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec

The use of Terraform's `remote-exec` and `local-exec` provisioners is not recommended for several reasons:

1. **Limited Idempotence:** Terraform is designed to be idempotent, meaning you can run `terraform apply` multiple times, and it should converge to the desired state without unintended changes. When you use `local-exec` or `remote-exec`, you're executing arbitrary commands on the local machine or a remote host, and these commands might not be idempotent. If the script fails or is run multiple times, it can lead to unpredictable or unwanted changes.

2. **Security Concerns:** Running arbitrary local or remote commands as part of your infrastructure provisioning can introduce security risks. If the Terraform configuration is used in a shared environment or by multiple users, it's important to carefully review and audit any scripts that are executed. Unauthorized or malicious code could be run if not properly secured.

3. **Limited Portability:** Terraform is designed to be cloud-agnostic, allowing you to manage resources across various cloud providers and services. Using `local-exec` or `remote-exec` ties your infrastructure provisioning to specific local or remote environments, making it less portable and more challenging to manage in a multi-cloud or hybrid cloud setup.

4. **Dependency on External Tools:** `local-exec` and `remote-exec` depend on external tools and scripts to perform actions outside of Terraform. This can lead to compatibility issues, especially if the required tools or scripts change or become unavailable.

5. **Lack of Reusability:** Terraform modules and providers provide a structured and reusable way to define and manage infrastructure resources. Using provisioners like `local-exec` or `remote-exec` often leads to ad-hoc, one-off solutions that are less reusable and harder to maintain.

6. **Limited Error Handling:** These provisioners have limited error handling capabilities. If a command executed via `local-exec` or `remote-exec` fails, it may not provide sufficient information or mechanisms for handling errors gracefully and recovering from failures.

While `local-exec` and `remote-exec` can be useful for certain tasks during development or for quick-and-dirty solutions, they should generally be avoided for critical production workloads. Instead, consider using Terraform's native resource types, data sources, and providers to manage your infrastructure resources. For more complex automation and configuration management tasks, you can integrate Terraform with dedicated automation tools or use Terraform in combination with other infrastructure as code (IAC) solutions like Ansible, Puppet, or Chef, which are designed for such tasks and offer better error handling, idempotence, and security controls.

## For Each Expressions

For each allows us to enumerate over complex data types e.g.

```sh
[for s in var.list : upper(s)]
```

This is mostly useful when you are creating multiples of a cloud resource and you want to reduce the amount of repetitive Terraform code.

[For Each Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)
