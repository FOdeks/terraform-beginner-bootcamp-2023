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
Note: Use ChatGPT to generate the tree structure in ASCII format.

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
