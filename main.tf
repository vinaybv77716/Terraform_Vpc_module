module "vpc"{
    source="./modules/vpc"
    vpc-cidr=var.vpc-cidr
    subnet-cidr=var.subnet-cidr
}