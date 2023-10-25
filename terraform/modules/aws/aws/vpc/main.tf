resource "aws_vpc" "main" {
  cidr_block       = var.cidr

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "gws" {
  for_each = var.internet_gws
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-${each.value.name}"
  }
}

resource "aws_subnet" "main" {
  for_each = var.subnets
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.name}-${each.value.name}"
  }
  cidr_block = each.value.cidr
  map_public_ip_on_launch = each.value.public_ip_on_launch
  availability_zone = each.value.availability_zone
}

resource "aws_nat_gateway" "nats" {
  for_each = var.nat_gws
  allocation_id = aws_eip.nats[each.key].id
  subnet_id = aws_subnet.main[each.value.subnet].id
  tags = {
    Name = "${var.name}-${each.value.name}"
  }

  depends_on = [
    aws_internet_gateway.gws
  ]
}

resource "aws_eip" "nats" {
  for_each = var.nat_gws
}

resource "aws_route_table" "routes" {
  for_each = var.subnets
  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = [
      for route in each.value.routes:
      route
      if route.internet_gw != null
    ]
    content {
      cidr_block = route.value.cidr
      gateway_id = aws_internet_gateway.gws[route.value.internet_gw].id
    }
  }

  dynamic "route" {
    for_each = [
      for route in each.value.routes:
      route
      if route.nat_gw != null
    ]
    content {
      cidr_block = route.value.cidr
      nat_gateway_id = aws_nat_gateway.nats[route.value.nat_gw].id
    }
  }
route {
    cidr_block = var.cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${var.name}-${each.value.name}"
  }
}

resource "aws_route_table_association" "subnets" {
  for_each = var.subnets
  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.routes[each.key].id
}
