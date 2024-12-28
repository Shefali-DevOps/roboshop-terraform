module "vpc" {
  source= "./modules/vpc"

  cidr = var.vpc["cidr"]
  env = var.env
  public_subnets = var.vpc["public_subnets"]
  web_subnets = var.vpc["web_subnets"]
  app_subnets = var.vpc["app_subnets"]
  db_subnets = var.vpc["db_subnets"]
  availability_zones = var.vpc["availability_zones"]
  default_vpc_id     = var.vpc["default_vpc_id"]
  default_vpc_rt     = var.vpc["default_vpc_rt"]
  default_vpc_cidr   = var.vpc["default_vpc_cidr"]

}

module "apps" {
  source = "./modules/ec2"

  for_each      = var.ec2
  name          = each.key
  instance_type = each.value["instance_type"]
  allow_port    = each.value["allow_port"]
  allow_sg_cidr = each.value["allow_sg_cidr"]
  subnet_ids    = module.vpc.subnets[each.value[subnet_ref]]
  capacity      = each.value["capacity"]
  vpc_id        = module.vpc.vpc_id
  env           = var.env
  bastion_nodes = var.bastion_nodes
}