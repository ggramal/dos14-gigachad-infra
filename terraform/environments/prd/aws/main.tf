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

module "gigachad_rds" {
  source = "../../../modules/aws/rds/"
  for_each = local.rdss
  vpc_id = module.vpcs[each.value.vpc_name].vpc_id
  db_subnet_name = each.value.db_subnet_name
  publicly_accessible = each.value.publicly_accessible
  engine_version = each.value.engine_version
  name = each.value.vpc_name
  db_password = each.value.db_password
  engine = each.value.engine
  storage = each.value.storage
  instance_class = each.value.instance_class
  username = each.value.username
  password = each.value.password
  final_snap = each.value.final_snap
  sg_name = each.value.sg_name
  rds_subnet_ids = module.vpcs[each.key].rds_subnet_ids
  rds_sg = each.value.sg_rds
  identifier = each.value.identifier
}
