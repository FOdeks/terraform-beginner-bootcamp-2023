terraform {
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "FandF"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

  cloud {
    organization = "FandF"
    workspaces {
      name = "terra-house-1"
    }
  }

  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}

module "home_smoothjazz_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.smoothjazz.public_path
  content_version = var.smoothjazz.content_version
}

resource "terratowns_home" "home_smoothjazz" {
  name            = "My Favorite Smooth Jazz Artists"
  description     = <<DESCRIPTION
"Smooth Jazz is a subgenre of contemporary jazz that emerged in the late 20th century and is characterized by its focus on creating a mellow, relaxing, and often commercially accessible sound. Smooth jazz often features a prominent use of saxophones, keyboards, and synthesizers, with a strong emphasis on melody and a generally laid-back groove. Smooth Jazz is known for its smooth and polished production values, making it more accessible to a wider audience compared to some other jazz subgenres. Smooth Jazz is often played on radio stations that specialize in easy listening or instrumental music." - ChatGPT
DESCRIPTION
  domain_name     = module.home_smoothjazz_hosting.domain_name
  town            = "melomaniac-mansion"
  content_version = var.smoothjazz.content_version
}

module "home_crabdish_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.crabdish.public_path
  content_version = var.crabdish.content_version
}

resource "terratowns_home" "home_crabdish" {
  name            = "Interested In A Crab Dish???"
  description     = <<DESCRIPTION
Crab Dish To Make this Fall And Beyond. Southeastern Asian Flavor Curry Crab – one of the two most popular ways that crab is served in China, Malaysia and Singapore. It is made with dungeness crabs and curry. I had so much fun making the dish.
Disclaimer: The recipe was shared by a colleague at work.
DESCRIPTION
  domain_name     = module.home_crabdish_hosting.domain_name
  town            = "cooker-cove"
  content_version = var.crabdish.content_version
}

/*
Alternative solution from a Terraformer to simplify the process of creating multiple homes. Add a module and resource to the main.tf file and declare new variables.
The solution involves making changes to a single file.- 

Here is what i did:

I've created a file named locals.tf where I've stored the values required to create our resources. The "hostings" contains values required by the module "terrahome_aws", and the "homes"  has values needed by our resource "terratowns_home".

locals {
  hostings = {
    "home_name1_hosting" = {
        public_path = "/workspace/terraform-beginner-bootcamp-2023/public/name1"
        content_version = 1
    }
  }
  homes = {
    "home_name1" = {
        name = "Title for the home"
        description = <<DESCRIPTION
        Description of the home.
        DESCRIPTION
        domain_name = module.terrahome_aws["home_name1_hosting"].domain_name
        town = "missingo"
        content_version = 1
    }
  }
}

In the main.tf file, I used the for_each loop to pass values to the module and resource, so it will execute for every hosting and home provided in the locals.tf file.

module "terrahome_aws" {
  for_each = local.hostings
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = each.value.public_path
  content_version = each.value.content_version
}

resource "terratowns_home" "home" {
  for_each = local.homes
  name = each.value.name
  description = each.value.description
  domain_name = each.value.domain_name
  town =  each.value.town
  content_version = each.value.content_version
}


And in output.tf, for each output, I used a for loop to retrieve values from the module for each home.

output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value = {for k in keys(local.hostings) : k => module.terrahome_aws[k].bucket_name}
}

output "s3_website_endpoint" {
  description = "S3 Static Website hosting endpoint"
  value = {for k in keys(local.hostings) : k => module.terrahome_aws[k].website_endpoint}
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value = {for k in keys(local.hostings) : k => module.terrahome_aws[k].domain_name}
}


I deleted the object type variables related to homes from the variables.tf and .tfvars files.

Now, when we want to create a new home, we only need to make modifications in the locals.tf file: add a new "home_name2_hosting" with its values to the hostings section and add a new "name2" home with its values to the homes section.

locals {
  hostings = {
    "home_name1_hosting" = {
        public_path = "/workspace/terraform-beginner-bootcamp-2023/public/name1"
        content_version = 1
    }
    "home_name2_hosting" = {
        public_path = "/workspace/terraform-beginner-bootcamp-2023/public/name2"
        content_version = 1
    }
  }
  homes = {
    "home_name1" = {
        name = "Title for the home"
        description = <<DESCRIPTION
        Description of the home.
        DESCRIPTION
        domain_name = module.terrahome_aws["home_name1_hosting"].domain_name
        town = "missingo"
        content_version = 1
    }
    "home_name2" = {
        name = "Title for the home"
        description = <<DESCRIPTION
        Description for the home
        DESCRIPTION
        domain_name = module.terrahome_aws["home_name2_hosting"].domain_name
        town = "missingo"
        content_version = 1
    }
  }
}
*/
