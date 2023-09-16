resource "aws_autoscaling_group" "tf-gigachad-asg" {
  launch_template {
    id      = var.lt-id
    version = "$Latest"
  }
  name                      = var.name
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  vpc_zone_identifier       = var.subnet_ids

}

resource "aws_security_group" "asg_security_group" {
  name        = "asg-security-group"
  description = "ASG Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}