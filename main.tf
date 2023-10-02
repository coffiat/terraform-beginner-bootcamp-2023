terraform {
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

module "terrahouse-aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}