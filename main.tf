terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}
provider "terratowns" {
  endpoint  = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token     = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

# cloud {
#   organization = "FandF"
#   workspaces {
#     name = "terra-house-1"
#   }
# }



#module "terrahouse_aws" {
#  source              = "./modules/terrahouse_aws"
#  user_uuid           = var.user_uuid
#  bucket_name         = var.bucket_name
#  index_html_filepath = var.index_html_filepath
#  error_html_filepath = var.error_html_filepath
#  content_version     = var.content_version
#  assets_path         = var.assets_path
#}

resource "terratowns_home" "smooth_jazz" {
  name = "Smooth Jazz Artists!"
  description = <<DESCRIPTION
"Smooth jazz is a subgenre of contemporary jazz that emerged in the late 20th century and is characterized by its focus on creating a mellow, relaxing, and often commercially accessible sound. Smooth jazz often features a prominent use of saxophones, keyboards, and synthesizers, with a strong emphasis on melody and a generally laid-back groove. It is known for its smooth and polished production values, making it more accessible to a wider audience compared to some other jazz subgenres. Smooth jazz is often played on radio stations that specialize in easy listening or instrumental music." - ChatGPT
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "melomaniac-mansion"
  content_version = 1
}