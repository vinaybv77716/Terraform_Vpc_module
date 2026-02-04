variable "vpc_cidr" {}
variable "public_subnets" {
  type = list(string)
}

variable "instance_type" {}

variable "ip_addresses" {
  type = list(string)
}

variable "blocked_countries" {
  type = list(string)
}
