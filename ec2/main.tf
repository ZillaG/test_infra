// Create a VPC with passed-in CIDR
module "vpc" {
  source = "../modules/vpc"
  cidr   = var.vpc_cidr
  name   = "test_vpc"
}

// Create and internet GW for public access
module "gateway" {
  source = "../modules/pub_gateway"
  vpc_id = module.vpc.vpc_id
  name   = "test_gw"
}

// Create a route table that can be used by the internet GW as default
module "route_table" {
  source     = "../modules/route_table"
  vpc_id     = module.vpc.vpc_id
  name       = "default"
  gateway_id = module.gateway.gw_id
}

// Create a subnet for the AZ
module "subnet" {
  source            = "../modules/subnet"
  availability_zone = var.availability_zone
  cidr              = var.vpc_cidr
  name              = "test_subnet"
  vpc_id            = module.vpc.vpc_id
}

// Create security groups with ingress and egress rules
module "security_group" {
  source              = "../modules/security_group"
  cidr_blocks         = [var.vpc_cidr]
  name                = "test_sg"
  vpc_cidr            = var.vpc_cidr
  vpc_id              = module.vpc.vpc_id
  your_home_public_ip = var.home_public_ip
}

// Get the AMI to be used to build the EC2s for the launch template
module "ami" {
  source = "../modules/ami"
}

// Key pair to use for EC2 ssh access
module "key_pair" {
  source = "../modules/key_pair"
  key_name = "test-user-rsa"
  public_key = var.public_key
}

// Launch template to be used by the ASG group below
module "launch_template" {
  source                 = "../modules/launch_template"
  ami_id                 = module.ami.ami_id
  availability_zone      = var.availability_zone
  key_name               = module.key_pair.key_pair_id
  subnet_id              = module.subnet.subnet_id
  vpc_security_group_ids = [module.security_group.security_group_id]
}

// Auto-scaling group that builds out EC2s that run the app; I purposedly
// hard-coded the counts to minimize my AWS costs
module "autoscaling_group" {
  source             = "../modules/autoscaling_group"
  availability_zones = [var.availability_zone]
  desired_capacity   = 1
  min_size           = 1
  max_size           = 2
  launch_template_id = module.launch_template.launch_template_id
}

// Outputs to help navigate through AWS console
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

output "module_launch_template_id" {
  value = module.launch_template.launch_template_id
}

output "module_autoscaling_group_id" {
  value = module.autoscaling_group.autoscaling_group_id
}
