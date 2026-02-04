variable "vpc-cidr" {
  type        = string
  description = "description"
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "public-subnet-tags" {
  type = map(string)
}

variable "private-subnet-tags" {
  type = map(string)
}

variable "ec2_names" {
    description = "EC2 names"
    type = list(string)
}

# variable "iam_instance_profile_name" {
#   description = "IAM role for ssm"
#   type = string
# }
