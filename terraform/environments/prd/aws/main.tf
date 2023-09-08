terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }
  backend "s3" {
    bucket = "dos14-tf-state"
    key = "gigachad/prd/aws/state.tfstate"
    dynamodb_table = "tf_state_gigachad"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-west-2"
}


module "vpcs" {
  source =  "../../../modules/aws/vpc/"
  for_each = local.vpcs
  name = each.value.name
  cidr = each.value.cidr
  internet_gws = each.value.internet_gws
  nat_gws = each.value.nat_gws
  subnets = each.value.subnets
}
