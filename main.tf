module "vpc" {
  source               = "./modules/vpc"
  vpc-cidr             = var.vpc-cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  public-subnet-tags   = var.public-subnet-tags
  private-subnet-tags  = var.private-subnet-tags
}
module "mysg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}
module "iam" {
  source = "./modules/IAM"
}
module "ec2" {
  source                    = "./modules/ec2"
  sg_id                     = module.mysg.sg_id
  subnets                   = module.vpc.private_subnet_ids
  ec2_names                 = var.ec2_names
  iam_instance_profile_name = module.iam.ec2_ssm_instance_profile_name
}
module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  alb_sg_id         = module.mysg.sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
 instance = module.ec2.instance
}



