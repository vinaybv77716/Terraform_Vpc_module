module "vpc"{
    source="./modules/vpc"
    vpc-cidr=var.vpc-cidr
    subnet-cidr=var.subnet-cidr
}
module "mysg"{
    source="./modules/sg"
    vpc_id=module.vpc.vpc_id
}