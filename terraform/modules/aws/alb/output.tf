output "alb_public_url" {
  description = "Public URL for Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_security_group" {
  description = "Public URL for Application Load Balancer"
  value       = aws_security_group.alb_security_group
}