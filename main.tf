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
  cloud {
    organization = "DSG-PRODUCTION"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token     = var.terratowns_access_token
}
module "home_dragon-ball_hosting" {
  source          = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.dragon-ball.public_path
  content_version = var.dragon-ball.content_version
}

resource "terratowns_home" "home" {
  name        = " How to play DBZ in 2023!"
  description = <<DESCRIPTION
Dragon Ball games have been primarily released in Japan since 1986.
With the majority of them being produced by Bandai.
In 2000, Infogrames acquired the license to produce and release Dragon Ball games for the North American and international market.[4] With the release of their first two titles in the franchise, 2002's Dragon Ball Z: The Legacy of Goku and Dragon Ball Z: Budokai,
Infogrames more than doubled their sales.
DESCRIPTION
  domain_name = module.home_dragon-ball.domain_name
  #domain_name = "3fdq3gz.cloudfront.net"
  town            = "missingo"
  content_version = "1"

}


module "home_payday_hosting" {
  source         = "./modules/terrahome_aws"
  user_uuid       = var.teacherseat_user_uuid
  public_path     = var.payday.public_path
  content_version = var.payday.content_version
}
resource "terratowns_home" "home_payday" {
  name            = "Making your Payday Bar"
  description     = <<DESCRIPTION
Since I really like Payday candy bars but they cost so much to import
into Canada, I decided I would see how I could my own Paydays bars,
and if they are most cost effective.
DESCRIPTION
  domain_name     = module.home_payday_hosting.domain_name
  town            = "missingo"
  content_version = var.payday.content_version
}