terraform {
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

# cloud {
#   organization = "FandF"
#   workspaces {
#     name = "terra-house-1"
#   }
# }



module "terrahouse_aws" {
  source              = "./modules/terrahouse_aws"
  user_uuid           = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version     = var.content_version
  assets_path         = var.assets_path
}

resource "terratowns_home" "smooth_jazz" {
  name        = "Smooth Jazz Artists!"
  description = <<DESCRIPTION
"Smooth jazz is a subgenre of contemporary jazz that emerged in the late 20th century and is characterized by its focus on creating a mellow, relaxing, and often commercially accessible sound. Smooth jazz often features a prominent use of saxophones, keyboards, and synthesizers, with a strong emphasis on melody and a generally laid-back groove. It is known for its smooth and polished production values, making it more accessible to a wider audience compared to some other jazz subgenres. Smooth jazz is often played on radio stations that specialize in easy listening or instrumental music." - ChatGPT
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fafa3.cloudfront.net"
  town            = "missingo"
  content_version = 1
}