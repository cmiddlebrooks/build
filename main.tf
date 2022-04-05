module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name            = var.vpc_name
  cidr            = var.vpc_cidr
  azs             = var.vpc_azs
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets

  tags = var.vpc_tags
}

output "vpc_id" {
  description = "ID of ctrl VPC"
  value       = module.vpc.vpc_id
}
