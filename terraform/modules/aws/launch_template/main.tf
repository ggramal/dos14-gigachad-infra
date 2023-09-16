resource "aws_launch_template" "main" {
  name = var.name
  image_id = var.image_id
  instance_type = var.instance_type

  network_interfaces {
    device_index    = 0
    security_groups = [var.asg_security_group_id]
  }


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "gigachad-bank-tf"
    }
  }
  
}
