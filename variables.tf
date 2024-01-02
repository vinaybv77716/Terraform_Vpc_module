variable "vpc-cidr" {
  type        = string
  description = "description"
}
variable "subnet-cidr"{
    type=list(string)
    description="2-subnet"
}