variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}
# alb_sg_id
variable "instance_ids" {
  type    = list(string)
  default = []
}

variable "instance" {
  description = "EC2 instance IDs to attach to target group"
  type        = list(string)
}
