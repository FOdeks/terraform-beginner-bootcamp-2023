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
  source              = "./modules/terrahome_aws"
  user_uuid           = var.teacherseat_user_uuid
  public_path = var.smoothjazz.public_path
  content_version     = var.smoothjazz.content_version
}

resource "terratowns_home" "home_smoothjazz" {
  name        = "Smooth Jazz Artists"
  description = <<DESCRIPTION
"Smooth Jazz is a subgenre of contemporary jazz that emerged in the late 20th century and is characterized by its focus on creating a mellow, relaxing, and often commercially accessible sound. Smooth jazz often features a prominent use of saxophones, keyboards, and synthesizers, with a strong emphasis on melody and a generally laid-back groove. It is known for its smooth and polished production values, making it more accessible to a wider audience compared to some other jazz subgenres. Smooth Jazz is often played on radio stations that specialize in easy listening or instrumental music." - ChatGPT
DESCRIPTION
  domain_name = module.home_smoothjazz_hosting.domain_name
  town            = "missingo"
  content_version = var.smoothjazz.content_version
}

module "home_crabdish_hosting" {
  source              = "./modules/terrahome_aws"
  user_uuid           = var.teacherseat_user_uuid
  public_path = var.crabdish.public_path
  content_version     = var.crabdish.content_version
}

resource "terratowns_home" "home_crabdish" {
  name        = "Making A Crab Dish"
  description = <<DESCRIPTION
Crab Dish To Make this Fall And Beyond. Black Pepper Crab – one of the two most popular ways that crab is served in Malaysia and Singapore. It is made with hard-shell crabs, and fried with black pepper. The second dish is Crab in Oyster sauce.
DESCRIPTION
  domain_name = module.home_crabdish_hosting.domain_name
  town            = "missingo"
  content_version = var.crabdish.content_version
}