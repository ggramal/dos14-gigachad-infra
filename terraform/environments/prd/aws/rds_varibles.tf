locals {
rdss = {
gigachad-tf = {
  engine              = "postgres"
  storage             = "5"
  db_subnet_name      = "subnet-db"
  publicly_accessible = false
  vpc_name            = "gigachad-tf"
  db_password         = random_password.db_password.result
  engine_version      = "14.3"
  instance_class      = "db.t3.micro"
  username            = "giga"
  password = {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  }
  identifier          = "gigachad-rds-tf"
  final_snap          = "true"
  sg_name             = "sg-rds-db"
  sg_rds = {

    ingress = {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
    }
    egress = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
}
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


