variable "vpc_id" {
}

variable "rds_subnet_ids" {
}

variable "engine" {
  description = "db_engine"
  type        = string
}

variable "db_subnet_name" {
  description = "db_subnet_name"
  type        = string
}

variable "publicly_accessible" {
  description = "publicly_accessible"
  type        = bool
}

variable "name" {
  description = "db_name"
  type        = string
}

variable "db_password" {
  description = "db_password"
  type        = string
}
variable "storage" {
  description = "allocated_storage"
  type        = number
}

variable "engine_version" {
  description = "engine_version"
  type        = string
}

variable "instance_class" {
  description = "instance_class"
  type        = string
}

variable "password" {
  description = "RDS root user password"
  type        = object(
    {
      length           = number
      special          = bool
      override_special = string
    }
  )
}

variable "username" {
  description = "DB username"
  type        = string
  sensitive   = true
}

variable "final_snap" {
  description = "skip final snapshot"
  type        = bool
}

variable "identifier" {
  description = "gigachad-tf"
}

variable "sg_name" {
  description = "RDS security groups name"
  type        = string
}

variable "rds_sg" {
  description = "RDS secret group"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
