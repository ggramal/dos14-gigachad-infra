output "subnets" {
  value = {
    for subnet_name, subnet_obj in aws_subnet.main:
    subnet_name => subnet_obj
  }
}
