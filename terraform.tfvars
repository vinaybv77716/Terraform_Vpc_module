vpc-cidr             = "10.10.0.0/16"
public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
private_subnet_cidrs = ["10.10.3.0/24", "10.10.4.0/24"]
public-subnet-tags = {
  "Environment" = "Dev"
  "Owner"       = "Vinay"
}
private-subnet-tags = {
  "Environment" = "Dev"
  "Owner"       = "Vinay"
}
ec2_names = ["AppServer1"]
  waf_name = "web-alb-waf"