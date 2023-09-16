variable "lt-id" {
}

variable "subnet_ids" {
}

variable "vpc_id" {
  
}

variable "alb_security_group" {
  
}

variable "name" {
  description = "ASG name"
  type = string
}

# variable "subnets" {
#   description = "ASG subnets"
#   type = map(
#     object(
#         {
#             subnet_id = string
#         }
#     )
#   )
# }