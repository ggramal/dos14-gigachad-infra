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

locals {
#  instances = {
#    "instance1" = {
#      name = "tf-example-1"
#    }
#  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "authz" {
  for_each               = local.instances
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t3.micro"
  key_name = "gae"
  vpc_security_group_ids = ["sg-041f0f77864869a9b"]
  tags = {
    Name = each.value.name
  }
}

module "vpc" {
  source = "../../../modules/aws/vpc/"
  for_each = local.vpcs
  name = each.value.name
  cidr = each.value.cidr
  internet_gws = each.value.internet_gws
  nat_gws = each.value.nat_gws
  subnets = each.value.subnets
}
