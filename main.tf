module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones = var.availability_zones
}

module "security" {
  source = "./modules/security"

  vpc_id = module.vpc.vpc_id
}

module "focalboard" {
  source = "./modules/focalboard"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_ids = [module.security.instance_sg_id]
  instance_type      = var.instance_type
  key_name           = var.key_name
  ami_id             = var.ami_id
}


module "alb" {
  source = "./modules/alb"

  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  security_group_id     = module.security.alb_sg_id
  focalboard_instance  = module.focalboard.instance_id
}