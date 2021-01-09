module "vpc" {
  source = "../modules/vpc"
  cidr   = var.cidr
  name   = "test_vpc"
}

module "gateway" {
  source = "../modules/pub_gateway"
  vpc_id = module.vpc.vpc_id
  name   = "test_gw"
}

module "route_table" {
  source     = "../modules/route_table"
  vpc_id     = module.vpc.vpc_id
  name       = "default"
  gateway_id = module.gateway.gw_id
}

module "subnet" {
  source            = "../modules/subnet"
  availability_zone = var.availability_zone
  cidr              = var.cidr
  name              = "test_subnet"
  vpc_id            = module.vpc.vpc_id
}

module "security_group" {
  source      = "../modules/security_group"
  cidr_blocks = [var.cidr]
  name        = "test_sg"
  vpc_id      = module.vpc.vpc_id
}

module "ami" {
  source = "../modules/ami"
}

module "key_pair" {
  source = "../modules/key_pair"
  key_name = "test-user-rsa"
  public_key = var.public_key
}

module "ec2" {
  source                 = "../modules/ec2"
  ami_id                 = module.ami.ami_id
  availability_zone      = var.availability_zone
  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_id
  ec2_tag_name           = "test_ec2"
  subnet_id              = module.subnet.subnet_id
  termination_protection = false
  vpc_security_group_ids = [module.security_group.security_group_id]
}

output "module_ami_id" {
  value = module.ami.ami_id
}

output "module_gw_id" {
  value = module.gateway.gw_id
}

output "module_vpc_id" {
  value = module.vpc.vpc_id
}

output "module_subnet_id" {
  value = module.subnet.subnet_id
}

output "module_security_group_id" {
  value = module.security_group.security_group_id
}

output "module_ec2_id" {
  value = module.ec2.ec2_id
}

output "module_ec2_priv_ip" {
  value = module.ec2.ec2_priv_ip
}

output "module_ec2_pub_ip" {
  value = module.ec2.ec2_pub_ip
}
