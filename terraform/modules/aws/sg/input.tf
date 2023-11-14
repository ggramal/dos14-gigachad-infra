variable "vpc_id" {
  # description = "VPC ID"
}


variable "name" {
  description = "SG name"
  type = string  
}

variable "description" {
  description = "SG Description"
  type = string
}

variable "sg_ingress" {
  description = "Ingress variables for SG"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    secrurity_groups = optional(list(string))
    cidr_blocks = optional(list(string))
  }))
}

variable "sg_egress" {
  description = "Egress variables for SG"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    secrurity_groups = optional(list(string))
    cidr_blocks = optional(list(string))
  }))
}
