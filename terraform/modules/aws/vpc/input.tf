{
  vps = {
    gigachad-tf = {
      name = "gigachad-tf"
      cidr = "10.0.0.0/16"
      internet_gws = {
        "igw1" = {
	  name = "igw1"
	}
      }
      nat_gws = {
        nat1 = {
	  name = "nat1"
	}
        nat2 = {
	  name = "nat2"
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
	      gateway_name = "igw1"
	    }
	  ]
	}
        private-subnet1 = {
	  name = "private-subnet1"
	  cidr = "10.0.16.0/24"
	  availability_zone = "eu-west-2a"
          routes = [
	    {
	      cidr = "0.0.0.0/0"
	      nat_name = "nat1"
	    }
	  ]
	}
      }
    }
  }
}
