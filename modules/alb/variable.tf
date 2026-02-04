variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "instance" {
  description = "EC2 instance IDs to attach to target group"
  type        = list(string)
}
