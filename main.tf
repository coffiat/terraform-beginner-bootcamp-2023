terraform {
  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

  #    backend "remote" {
  #      hostname = "app.terraform.io"
  #      organization = "DSG"
  #    }
  #   workspaces {
  #        name = "terra-house-1"
  #}
  # cloud {
  #    organization = "DSG-PRODUCTION"
  #    workspaces {
  #        name = "terra-house-1"
  #    }
  #}

}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var. teacherseat_user_uuid
  token     = var.terratowns_access_token
}
module "terrahouse-aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  error_html_filepath = var.error_html_filepath
  index_html_filepath = var.index_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name        = " How to play DBZ in 2023!"
  description = <<DESCRIPTION
Dragon Ball games have been primarily released in Japan since 1986.
With the majority of them being produced by Bandai.
In 2000, Infogrames acquired the license to produce and release Dragon Ball games for the North American and international market.[4] With the release of their first two titles in the franchise, 2002's Dragon Ball Z: The Legacy of Goku and Dragon Ball Z: Budokai,
Infogrames more than doubled their sales.
DESCRIPTION
  domain_name = module.terrahouse-aws.cloudfront_url
  #domain_name = "3fdq3gz.cloudfront.net"
    town            = "missingo"
  content_version = "1"

}