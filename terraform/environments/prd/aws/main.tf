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
  name = local.vpcs.gigachad-tf.name
  cidr = local.vpcs.gigachad-tf.cidr
  internet_gws = local.vpcs.gigachad-tf.internet_gws
  nat_gws = local.vpcs.gigachad-tf.nat_gws
  subnets = local.vpcs.gigachad-tf.subnets
  rds_subnets = local.vpcs.gigachad-tf.rds_subnets
}



module "gigachad_rds" {
  source = "../../../modules/aws/rds/"
  vpc_id = module.vpcs.vpc_id
  db_subnet_name = local.gigachad_rds.db_subnet_name
  publicly_accessible = local.gigachad_rds.publicly_accessible
  engine_version = local.gigachad_rds.engine_version
  name = local.gigachad_rds.name
  engine = local.gigachad_rds.engine
  storage = local.gigachad_rds.storage
  instance_class = local.gigachad_rds.instance_class
  username = local.gigachad_rds.username
  password = local.gigachad_rds.password
  final_snap = local.gigachad_rds.final_snap
  sg_name = local.gigachad_rds.sg_name
  rds_subnet_ids = module.vpcs.rds_subnet_ids
  rds_sg = local.sg_rds
  identifier = local.gigachad_rds.identifier
}
