variable "alb_arn" {
  description = "ARN of the ALB to attach WAF to"
  type        = string
}

variable "waf_name" {
  description = "Name for the WAF Web ACL (alphanumeric, -, _ only)"
  type        = string
  default     = "web-alb-waf"
}
