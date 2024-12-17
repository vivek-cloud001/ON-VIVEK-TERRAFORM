output "lb_dns_name" {
  description = "DNS Name of load balancer"
  value       = aws_lb.application_load_balancer.dns_name
}