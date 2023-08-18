locals {
  vpcs = {
    gigachad-tf = {
      name = "gigachad-tf"
      cidr = "10.0.0.0/16"  
      internet_gws = {
        "igw-1" = {
          name = "igw-1"
        }
      }
      nat_gws = {
        "nat-1" = {
          name = "nat-1"
          subnet = "private-subnet1"
        }
      }
      subnets = {
        public-subnet1 = {
          name = "public-subnet1"
          cidr = "10.0.1.0/24"
          public_ip_on_launch = true
          availability_zone = "eu-west-2a"
          routes = [
            {
              cidr = "0.0.0.0/0"
              internet_gw = "igw-1"
            }
          ]
        }
        private-subnet1 = {
          name = "private-subnet1"
          cidr = "10.0.2.0/24"
          availability_zone = "eu-west-2c"
          routes = [
            {
              cidr = "0.0.0.0/0"
              nat_gw = "nat-1"
            }
          ]
        }
      }
    }
    gigachad-tf-2 = {
      name = "gigachad-tf-2"
      cidr = "10.0.0.0/16"  
      internet_gws = {
        "igw-1" = {
          name = "igw-1"
        }
      }
      nat_gws = {
        "nat-1" = {
          name = "nat-1"
          subnet = "private-subnet1"
        }
      }
      subnets = {
        public-subnet1 = {
          name = "public-subnet1"
          cidr = "10.0.3.0/24"
          public_ip_on_launch = true
          availability_zone = "eu-west-2a"
          routes = [
            {
              cidr = "0.0.0.0/0"
              internet_gw = "igw-1"
            }
          ]
        }
        private-subnet1 = {
          name = "private-subnet1"
          cidr = "10.0.4.0/24"
          availability_zone = "eu-west-2c"
          routes = [
            {
              cidr = "0.0.0.0/0"
              nat_gw = "nat-1"
            }
          ]
        }
      }
    }
  }
}
