resource "aws_vpavailability_zonec" "main" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = ""

  tags = {
    Name = "Main"
  }
}


resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.example.id
  }

  route {
    cidr_block = "10.0.1.0/24"
    nat_gateway_id = aws_internet_gateway.example.id
  }

  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "example"
  }

}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.foo.id
  route_table_id = aws_route_table.bar.id
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw1"
  }
}


resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.example.id

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_eip" "lb" {
  domain   = "vpc"
}
