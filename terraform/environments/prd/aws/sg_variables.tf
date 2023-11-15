locals {
    sgroups = {
      sgroup-1 = {
        name = "gigachad-sg-1"
        description = "Custom SG #1"
        ingresses = [
          {
            from_port = 22
            to_port = 22
            protocol = "TCP"
          },
          {
            from_port = 80
            to_port = 80
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
          }
        ]
        egress = [
          {
            from_port = 0
            to_port = 0
            protocol = -1
          }
        ]
      }
      sgroup-2 = {
        name = "gigachad-sg-2"
        description = "Custom SG #2"
        ingresses = [
          {
            from_port = 1
            to_port = 22
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
          },
          {
            from_port = 80
            to_port = 88
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
          }
        ]
        egress = [
          {
            from_port = 0
            to_port = 65535
            protocol = "TCP"
            cidr_blocks = ["10.0.0.0/8"]
          }
        ]
      }   
    }
}