module "vpc"{
    source="./modules/vpc"
    vpc-cidr=var.vpc-cidr
    subnet-cidr=var.subnet-cidr
}
module "mysg"{
    source="./modules/sg"
    vpc_id=module.vpc.vpc_id
}
module "ec2" {
  source = "./modules/ec2"
  sg_id = module.mysg.sg_id
  subnets = module.vpc.subnet_ids
}
this is pru code
