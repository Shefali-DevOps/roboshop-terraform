output "dns_name" {
  value = aws_lb.main.dns_name
}

output "private_listener" {
  value = aws_lb_listener.main.arn
}