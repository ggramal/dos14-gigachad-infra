locals {
    sgroups = {
      sgroup-1 = {
        name = "gigachad-sg-1"
        description = "Custom SG #1"
        # vpc_id = data.aws_vpc.main.vpc_id
        ingresses = {
          ingress-1 = {
              from_port = 22
              to_port = 22
              protocol = "TCP"
            }
          ingress-2 = {
              from_port = 80
              to_port = 80
              protocol = "TCP"
              cidr_blocks = ["0.0.0.0/0"]
            }
        }
        egress = {
          egress-1 = {
            from_port = 0
            to_port = 0
            protocol = -1
          }
        }
      }
      sgroup-2 = {
        name = "gigachad-sg-2"
        description = "Custom SG #2"
        # vpc_id = data.aws_vpc.main.vpc_id
        ingresses = {
          ingress-1 = {
            from_port = 1
            to_port = 22
            protocol = "TCP"
          }
        }
        egress = {
          egress-1 = {
            from_port = 0
            to_port = 65535
            protocol = "TCP"
          }
        }
      }   
    }
}