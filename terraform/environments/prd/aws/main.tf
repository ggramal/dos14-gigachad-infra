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
  vpc_id = module.vpcs[each.value.gigachad_rds.vpc_name].vpc_id
  db_subnet_name = each.value.gigachad_rds.db_subnet_name
  publicly_accessible = each.value.gigachad_rds.publicly_accessible
  engine_version = each.value.gigachad_rds.engine_version
  name = each.value.gigachad_rds.vpc_name
  engine = each.value.gigachad_rds.engine
  storage = each.value.gigachad_rds.storage
  instance_class = each.value.gigachad_rds.instance_class
  username = each.value.gigachad_rds.username
  password = each.value.gigachad_rds.password
  final_snap = each.value.gigachad_rds.final_snap
  sg_name = each.value.gigachad_rds.sg_name
  rds_subnet_ids = module.vpcs[each.key].rds_subnet_ids
  rds_sg = each.value.sg_rds
  identifier = each.value.gigachad_rds.identifier
}
