output "alb_dns" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}
output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}