# CIDR block for the VPC
vpc-cidr             = "10.10.0.0/16"
# CIDR blocks for public subnets
public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
# CIDR blocks for private subnets
private_subnet_cidrs = ["10.10.3.0/24", "10.10.4.0/24"]
# Tags for public subnets
public-subnet-tags = {
  "Environment" = "Dev"
  "Owner"       = "Vinay"
}
# Tags for private subnets
private-subnet-tags = {
  "Environment" = "Dev"
  "Owner"       = "Vinay"
}
# EC2 instance names
ec2_names = ["AppServer1"]
# WAF name
waf_name = "web-alb-waf"