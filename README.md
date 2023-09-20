# Terraform Beginner Bootcamp 2023

- [Semantic Versioning](#semantic-versioning)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang Considerations](#shebang-considerations)
    + [Execution Considerations](#execution-considerations)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
- [Gitpod Lifecycle](#gitpod-lifecycle)
- [Working Env Vars](#working-env-vars)
  * [env command](#env-command)
  * [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
  * [Printing Vars](#printing-vars)
  * [Scoping of Env Vars](#scoping-of-env-vars)
  * [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
    + [Terraform Init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
- [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)

## Semantic Versioning

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, e.g. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) 


### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to your needs.

[How to Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version

```
$ cat /etc/os-release

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

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the the bash script, we can use the `./` shorthand notation to execute the bash scripts.

e.g. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml, we need to point the script to a program to interpret it.

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

https://en.wikipedia.org/wiki/Chmod

## Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using the **Init** because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working ENV Vars

We can list out all Environment Variables (Env Vars) using the `env` command.

We can filter specific env vars using grep e.g. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal, we can set using `export HELLO='world'`

In the terminal, we can unset using `unset HELLO`

```sh
HELLO='world' .bin/print_message
```

Within a bash script we can set env without writing export e.g.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

### Scoping of Env Vars

When you open up new bash terminals in VS Code, it will not be aware of env vars that you have set in another window.

If you want to env vars to persist across all future bash terminals that are open, you need to set env vars in your bash profile. e.g. `.bash_profile`

### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-senstive env vars.