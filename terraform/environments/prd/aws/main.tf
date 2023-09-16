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
  # for_each = local.vpcs
  name = local.vpcs.gigachad-tf.name
  cidr = local.vpcs.gigachad-tf.cidr
  internet_gws = local.vpcs.gigachad-tf.internet_gws
  nat_gws = local.vpcs.gigachad-tf.nat_gws
  subnets = local.vpcs.gigachad-tf.subnets
}

module "aws_launch_template" {
  source =  "../../../modules/aws/launch_template/"
  # for_each = local.launch-template
  name = local.launch-template.gigachad-lt-tf.name
  image_id = local.launch-template.gigachad-lt-tf.image_id
  instance_type = local.launch-template.gigachad-lt-tf.instance_type
  asg_security_group_id = module.asg.asg_security_group_id
}

module "asg" {
  source =  "../../../modules/aws/asg/"
  # for_each = local.asg
  lt-id = module.aws_launch_template.lt-id
  name = local.asg.gigachad-asg.name
  subnet_ids = module.vpcs.subnet_ids
  alb_security_group = module.alb.alb_security_group
  vpc_id = module.vpcs.vpc_id
}

module "alb" {
  source = "../../../modules/aws/alb/"
  vpc_id = module.vpcs.vpc_id
  subnet_ids = module.vpcs.subnet_ids
}

