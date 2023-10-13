# Terraform Beginner Bootcamp 2023
## Week 0 - Getting Prepped!
- Creating a Discord Account and Verifying Email
- How to ask a good question to get help in the Discord
- How to take screenshots from the desktop
- How to write Github flavored Markdown
- How to add and edit files only using Github for documentation
- How to format images and include them in documentation in Github
- How to perform basic Git actions (pull, merge, push)
- How to submit your homework in the Student Portal
- How to write a good Summary for a weekly submission
- Copying the template Project Repo
- Navigating Terraform Registry
- Configure AWS Provider in the Terraform code
- Configure Remote State for Terraform Cloud
- Use the Random Terraform Provider
- Terraform Basic Commands
___

![architecture_diagram_week0](https://github.com/FOdeks/terraform-beginner-bootcamp-2023/assets/99102643/c4faffb1-d12c-42ee-bbda-53faef918d1e)

## Table of Contents
- [Semantic Versioning](#semantic-versioning)
- [Markdown Language](#markdown-language)
  * [Common elements in Markdown](#common-elements-in-markdown)
- [Markdown TOC Generator](#markdown-toc-generator)
- [Cloud-Based Development Environment](#cloud-based-development-environment)
  * [Gitpod Lifecycle](#gitpod-lifecycle)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang Considerations](#shebang-considerations)
    + [Execution Considerations](#execution-considerations)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
- [Working with Environment Variables](#working-with-environment-variables)
  * [env command](#env-command)
  * [Setting and Unsetting Environment Variables](#setting-and-unsetting-environment-variables)
  * [Printing Environment Variables](#printing-environment-variables)
  * [Scoping of Environment Variables](#scoping-of-environment-variables)
  * [Make Environment Variables Persist in Gitpod](#make-environment-variables-persist-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Workflow](#terraform-workflow)
    + [Terraform Init](#terraform-init)
    + [Terraform Validate](#terraform-validate)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
  * [Create S3 Bucket](#create-s3-bucket)
- [Terraform Cloud](#terraform-cloud)
  * [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)
  * [Key Features and Functions of Terraform Cloud](#key-features-and-functions-of-terraform-cloud)
  * [Migrating Terraform State File from Local Environment](#migrating-terraform-state-file-from-local-environment)
- [GitHub Code Update Flow](#github-code-update-flow)

## Semantic Versioning

This project is going to utilize Semantic Versioning for its tagging.

[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, e.g. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Markdown Language

Markdown is a lightweight markup language that is widely used for formatting plain text documents that could be converted into HTML. Markdown is often used for writing documentation, README files in software projects, forum posts, and more, especially on platforms like GitHub and Stack Overflow.

Markdown is designed to be both human-readable in its raw form, and easy to write, without the complexities of writing raw HTML or other markup languages. 

It uses a simple and intuitive system of symbols and formatting rules to define how text should be styled and structured. 

### Common elements in Markdown

- **Headers:** You can create headers by using one or more hash symbols (#) at the beginning of a line. More hash symbols indicate lower-level headers.

```sh
# Header 1
## Header 2
### Header 3
```

- **Text Styling:** You can apply formatting to text, such as making text bold, italic, or strikethrough using asterisks or underscores.

```md
*italic* or _italic_
**bold** or __bold__
~~strikethrough~~
```

- **Lists:** You can create ordered (numbered) and unordered (bulleted) lists.

```md
1. Item 1
2. Item 2

- Bullet 1
- Bullet 2
```

- **Links:** You can create links to other web pages or resources.

```less
[Google](https://www.google.com)
```

- Images: You can embed images in your document.

```mathematica
![Image Alt Text](image-url)
```

- **Code:** You can format inline code or code blocks using backticks or triple backticks.

```arduino
`inline code`

#```
code block
#```
```

- **Quotes:** You can create blockquotes by using the greater-than symbol (>) at the beginning of a line.

```css
> This is a blockquote.
```

[Markdown Guide](https://www.markdownguide.org/) 

## Markdown TOC Generator

The link below uses documentation developed and formatted in Markdown to generate MarkDown Table of Contents that can be copied and pasted.

[GitHub Markdown TOC Generator](https://luciopaiva.com/markdown-toc/)

## Cloud-Based Development Environment
[Gitpod](https://www.gitpod.io/docs/introduction/getting-started) offers a cloud-based, ready-to-code development environment that can be accessed from a web browser.

It is an online integrated development environment (IDE) often used by developers to improve productivity and collaboration when working on software projects, especially those hosted on Git repositories like GitHub.

It is designed to streamline the process of setting up, configuring, and sharing development environments, and helps ensure consistency across team members, particularly for projects that use Git for version control. 

**Key Features:**

- **Cloud-Based Development Environment:** Gitpod provides a fully functional development environment in the cloud. This means you can access your development workspace from anywhere with an internet connection, and you're not tied to a specific machine or operating system.

- **Git Integration:** Gitpod is tightly integrated with Git and GitHub. You can start a Gitpod environment directly from a GitHub repository by installing a [browser extension](https://www.gitpod.io/docs/configure/user-settings/browser-extension), thereby making it easier to work on open-source projects or collaborate with others.

- **Preconfigured Development Environments:** Gitpod allows you to define the development environment you need using a configuration file (typically a `.gitpod.yml` file). This file can specify the software, dependencies, and tools required for your project, and Gitpod will set up the environment automatically when you open your workspace.

- **Collaboration:** Multiple developers can collaborate in real-time on a Gitpod workspace, making it useful for pair programming or code reviews.

- **VS Code Integration:** Gitpod is built on the Visual Studio Code (VS Code) editor, which is a popular and feature-rich code editor. This means you get many of the features of VS Code, such as extensions and customizations, within Gitpod.

- **Scalability:** Gitpod is scalable, meaning you can configure it for large projects with multiple contributors or for smaller personal projects.

- **Automated Maintenance:** Gitpod takes care of routine tasks like updates, security patches, and environment maintenance, allowing developers to focus on writing code.

- **Pricing:** Gitpod offers both free and paid plans, with the free plan typically having some limitations on resources and usage.


### Gitpod Lifecycle

We need to be careful when using the **Init** because it will not rerun if we restart an existing workspace.

[Gitpod Tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) 

### Considerations for Linux Distribution

This project is built against Ubuntu.

Consider checking your Linux Distribution version and make changes accordingly to your needs.

Run this command to check OS version:

```
$ cat /etc/os-release
```

To dispay an output smiliar to this:

```
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

[How to Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues, we noticed that the bash scripts steps were a considerable amount of code. So we decided to create a bash script to install the Terrafom CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli).

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.

- This will allow us an easier way to debug and execute manually Terraform CLI install.

- This will allow better portability for other projects that need to install Terraform CLI.

#### Shebang Considerations

A Shebang (pronounced Sha-bang) tells the bash script what program will interpret the script. e.g. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability for different OS distributions

- will search the user's path for the bash executable

[shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations

When executing the the bash script, we can use the `./` shorthand notation to execute the bash scripts.

e.g. `./bin/install_terraform_cli`

If we are using a script in **.gitpod.yml**, we need to point the script to a program to interpret it.

e.g. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable, we need to change the linux permission for the file to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

[chmod](https://en.wikipedia.org/wiki/Chmod)

## Working with Environment Variables

### env command

List out all environment variables using the `env` command.

Filter for specific environmnent variables using **grep** e.g. `env | grep AWS_`

### Setting and Unsetting Environment Variables

Set using environmnent variables `export HELLO='world'`

Unset environmnent variables using `unset HELLO`

```sh
HELLO='world' .bin/print_message
```

Within a bash script we can set environmnent variables without writing export e.g.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Environment Variables

Print an environmnent variable using **echo** e.g.

```
echo $HELLO`
```

### Scoping of Environment Variables

When you open up new bash terminals in VS Code, it will not be aware of env vars that you have set in another window.

If you want to environment variables to persist across all future bash terminals that are open, you need to set env vars in your bash profile. e.g. `.bash_profile`

### Make Environment Variables Persist in Gitpod

To make environment variables persist in your Gitpod environment, use the `gp env` command:

```bash
gp env HELLO='world'

# Storing AWS Credentials
gp env AWS_ACCESS_KEY_ID=your_access_key_here
gp env AWS_SECRET_ACCESS_KEY=your_secret_key_here
gp env AWS_DEFAULT_REGION=your_region_here
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set environmnent variables in the `.gitpod.yml` but this can only contain non-senstive environmnent variables.

## AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[Configure AWS CLI Environment Variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if the AWS credentials is configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it is succesful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIDATESTNL2AWSEXAMPLE",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/Cinnabon"
}
```

> **Note:** We need to generate AWS CLI credentials from IAM User in order to the user AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform Registry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow for creating resources in terraform, e.g. [hashicorp/random](https://registry.terraform.io/providers/hashicorp/random).
- **Modules** are a way to make large amount of Terraform code modular, portable and sharable.

### Terraform Workflow

A list of all the Terraform commands will be displayed by simply typing `terraform` in the command prompt.

```bash
$ terraform
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

**Main commands:**
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

All other commands:
  console       Try Terraform expressions at an interactive command prompt
  fmt           Reformat your configuration in the standard style
  force-unlock  Release a stuck lock on the current workspace
  get           Install or upgrade remote Terraform modules
  graph         Generate a Graphviz graph of the steps in an operation
  import        Associate existing infrastructure with a Terraform resource
  login         Obtain and save credentials for a remote host
  logout        Remove locally-stored credentials for a remote host
  metadata      Metadata related commands
  output        Show output values from your root module
  providers     Show the providers required for this configuration
  refresh       Update the state to match remote systems
  show          Show the current state or a saved plan
  state         Advanced state management
  taint         Mark a resource instance as not fully functional
  test          Execute integration tests for Terraform modules
  untaint       Remove the 'tainted' state from a resource instance
  version       Show the current Terraform version
  workspace     Workspace management

Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.
```

#### Terraform Init

`terraform init`

This command is run at the start of a new Terraform project in order to download the binaries for the Terraform providers that will be used in the project.

#### Terraform Plan

`terraform plan`

This will generate out a changeset about the state of our infrastructure and what will be changed.

We can output this changeset i.e. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by Terraform. Apply should prompt us to type a choice of a **yes** or **no**.

If we want to automatically approve an apply we can provide the auto approve flag e.g. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`

This will destroy only resources provisioned using Terraform.

You can also use the **auto approve** flag to skip the approve prompt, e.g. `terraform apply --auto-approve`

#### Terraform Lock Files

`.terraform.lock.hcl` 

This file is created after executing the `terraform init` command. It contains the locked versioning for the providers or modulues that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VCS) e.g. Github

#### Terraform State Files

`terraform.tfstate`

This contains information about the current state of your infrastructure.

This file **should not be commited** to your VCS. This file can contain sensentive data.

If you lose this file, you lose knowing the state of your infrastructure.

`terraform.tfstate.backup`

This is the backup of the previous state file state.

#### Terraform Directory

`.terraform`

This folder is created after executing the `terraform init` command. The directory contains the binaries of Terraform providers.

### Create S3 Bucket

Create AWS S3 Bucket in Terrafrom using the **random** provider to genrate a bucket name.

1. Declare the **random** provider in the **main.tf** Terraform configuration file as follows:

```tf
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}
```

2. Locate the **random_string** resource in the Terraform Registry:

```tf
resource "random_string" "bucket_name" {
  length           = 16
  special          = true
  override_special = "/@£$"
```

3. From  `override_special =`, remove the **"/@£$"**.

```tf
resource "random_string" "bucket_name" {
  length           = 16
  special          = true
  override_special = ""
}
```

   Or just delete the `override_special` code and change the flag for `special` to **false**:

```tf
resource "random_string" "bucket_name" {
  length           = 16
  special          = false
}
```

4. Add an **output** block to return the random string value and use this for the bucket name:

```tf
output "random_bucket_name" {
 value = random_string.bucket_name.result
}
```

> **Note:** The **main.tf** configuration file is considered the top root module in Terraform. Modules are built within the root module. 

5. Configure the **AWS** provider in your Terraform configuration.
 
6. Go to the Terrafrom registry and search for **AWS** [provider](https://registry.terraform.io/providers/hashicorp/aws/latest) code.

   To install this provider, copy the code:

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
}
```

7. Paste this code into your Terraform configuration i.e. **main.tf**.:

```tf
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
}
```

8. Combine the **required_providers** code for **aws** and **random**

```tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

provider "aws" {
  # Configuration options
}
```

9. Search for the **aws_s3_bucket** resource code in the Terraform registry. You can find it [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket). 

10. Copy and paste the s3 resource code into the Terraform configuration: 

```tf
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
```

11. Change the bucket name from **"my-tf-test-bucket"** to **random_string.bucket_name.result**

```
resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
}
```

12. Update the resource definition for **random** as required and increase the **length** to reduce the chance of conflicts (S3 Bucket name must be unique).

   From:

```
resource "random_string" "bucket_name" {
  length           = 16
  special          = false
}
```

   To:

```
resource "random_string" "bucket_name" {
  lower = true
  upper = false
  length   = 32
  special  = false
}
```

   Run `terraform init` and then `terraform apply`. An error with the bucket name is returned.

**Fixing Bucket Naming Issue**

**Note:** In creating the S3 Bucket, and using the random provider to generate a bucket name, upper case characters which violated the bucket naming rules were generated. We reviewed the Random documentation and reset the random_string options. We added `lower=true`, `upper=false` and `special=false`.

[Bucket Naming Rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html)

13. To resolve the bucket naming issue, modify the resource definition for **random** as follows.

```
resource "random_string" "bucket_name" {
  lower = true
  upper = false
  length   = 32
  special  = false
}
```

Run `terraform apply` again to create the S3 bucket.

## Terraform Cloud

Terraform Cloud is designed to enhance the use of Terraform by providing a cloud-based service and centralized platform for managing and collaborating on infrastructure provisioning and management.

Terraform Cloud is a valuable tool for organizations and teams looking to streamline and scale their infrastructure provisioning and management processes using Terraform.

<img src="https://github.com/FOdeks/terraform-beginner-bootcamp-2023/assets/99102643/48b4a76e-e5df-4826-9d85-d6e51dd0710c" alt="Screenshot" width="800" height="500">

### Key Features and Functions of Terraform Cloud

1. **Remote State Management:** Terraform Cloud allows you to store the state files i.e. `.terraform.tfstate` generated by Terraform in a centralized and secure location. This helps in maintaining the state of your infrastructure and enables collaboration among team members.

2. **Collaboration:** Multiple team members can work on the same infrastructure code using Terraform Cloud. It provides role-based access control and audit trails to ensure secure collaboration.

3. **Remote Execution:** Terraform Cloud can execute `terraform plan` and `terraform apply` remotely, which is especially useful for running infrastructure changes in a controlled and collaborative environment.

4. **Workspaces:** Workspaces in Terraform Cloud provide a way to organize and separate different infrastructure configurations, making it easier to manage multiple environments, projects, or teams.

5. **Version Control Integration:** Terraform Cloud integrates with popular version control systems like GitHub, GitLab, and Bitbucket. This allows you to version and track your infrastructure code changes.

6. **Variable Management:** Terraform Cloud lets you manage and securely store variables, which can be used to parameterize your infrastructure configurations.

7. **Notifications:** Terraform Cloud offers alerting and notification features to keep teams informed about changes, runs, and other important events.

8. **API and CLI:** Terraform Cloud provides APIs and a command-line interface (CLI) for automation and integration with other tools and processes.

9. **Tiers:**  Terraform Cloud is available in both free and paid tiers, with the paid tiers offering additional features such as more extensive collaboration capabilities, access control, and other enterprise-level features. 

### Migrating Terraform State File from Local Environment

To migrate your `terraform.tfstate` from your local environment to Terraform Cloud, you need to configure remote state management using Terraform Cloud.

Here are the steps:

1. **Set up a Backend Configuration:**

   In your existing Terraform configuration, you will need to configure a backend that points to Terraform Cloud:

```tf
# Replace "your-organization-name" with the name of your Terraform Cloud organization and "your-workspace-name" with
# the name of the workspace in Terraform Cloud where you want to store the state.

terraform {
  cloud {
    organization = "your-organization-name"
    workspaces {
      name = "your-workspace-name"
    }
  }
}
```

2. **Initialize and Apply:**

   Once you have updated your Terraform configuration with the backend configuration, you need to initialize Terraform by running `terraform init` in order to apply the change.
 
3. **Confirm State Migration:**

   During the execution of the command, Terraform will prompt you to confirm the state migration. Ensure you confirm the migration to Terraform Cloud. This action will copy your local `terraform.tfstate` to the remote state storage in Terraform Cloud.

4. **Verify State in Terraform Cloud:**

   After confirming the state migration, you can verify that the state is now stored in Terraform Cloud by checking the workspace in the Terraform Cloud web interface.

Make sure you have the necessary Terraform Cloud credentials and permissions to write to the remote state. Also, you will need to log in to Terraform Cloud using the `terraform login` command before running `terraform init`. This command allows you to authenticate and set the necessary API token for communication with Terraform Cloud.

### Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` in **bash**, it launched a **wiswig* view to generate a token. However, it does not work as expected in Gitpod VS Code in the browser.

The workaround is to manually generate a token in Terraform Cloud.

```bash
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then, create and open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace with your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

We have automated this workaround with the following bash script:

[generate tfrc credentials](https://github.com/FOdeks/terraform-beginner-bootcamp-2023/blob/main/bin/generate_tfrc_credentials).

## GitHub Code Update Flow

1. **Issue Creation:** Begin by creating new issues. Provide a clear title, add comments, assign labels, and submit the issue.

2. **Branch Management:** Create a new branch (from the issue), perform a `git fetch`, and switch to the branch in you local repository.

3. **Action on open Issues:** Address open issues as required, making necessary changes or updates.

4. **Commit with Caution:** Before committing changes, ensure that there is no sensitive data in the filed being committed. Keep the commits clean and concise.

5. **Commit and Sync:** Commit the changes and sync them witjh the relevant issue number and name (e.g. '#1 add semantic versioning documentation to project').

6. **Pull Request Creation:** Create a `Pull Request`, `Squash and Merge`, and `confirm`.

7. **Maintain Main Branch:** Switch back to the Main branch, pull the latest changes, tag the work e.g. `git tag 1.0.0`, and push the tags `git push --tags` to the main repository.

8. **Review Tag Changes:** Refresh the Git Graph to view the updated tags and changes.    

![github_flow](https://github.com/FOdeks/terraform-beginner-bootcamp-2023/assets/99102643/3fae048d-4892-4391-989a-661eaebe1f9d)

Follow these guidelines to implement [Semantic Versioning](#semantic-versioning) in Git:

1. **Set Up a Repository:** If you don't already have a Git repository for your project, create one by initiating the **.git** directory.

```sh
git init
```

2. **Define Your Version Number**: Start by defining your initial version number. Semantic Versioning follows the format **MAJOR.MINOR.PATCH**, where:

   - `MAJOR` is incremented for significant, backward-incompatible changes.
   - `MINOR` is incremented for backward-compatible new features or improvements.
   - `PATCH` is incremented for backward-compatible bug fixes.

For example, if your project is at **version 1.0.0**, you can start with:

```sh
git tag 1.0.0
```

3. **Commit Your Changes**: Make sure that each commit message is descriptive and follows a conventional format, which includes a summary and, if needed, a detailed description.

```sh
git commit -m "feat: Add new feature X"
git commit -m "fix: Fix issue Y"
git commit -m "chore: Update dependencies"
```

4. **Bump Version Numbers**: When you're ready to release a new version, update the version number accordingly in your project. For example, if you are releasing a minor version, update the **MINOR** number:

```sh
git tag 1.1.0
```

5. **Write a Changelog**: Create a changelog that details the changes in this release, including new features, bug fixes, and any other noteworthy items. This helps users understand what has changed between versions.

6. **Push to Git**: Push your changes and tags to your Git repository:

```sh
git push origin master --tags
```

7. **Publish Your Release**: If your code is already on GitHub, simply push it to your remote.

```bash
git push --tags
```


