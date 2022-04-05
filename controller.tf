

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}


data "aws_caller_identity" "current" {}
/*
module "aviatrix-iam-roles" {
  source = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-iam-roles?ref=terraform_0.14"
}


Controller build prerequisites
# Existing VPC,
Public subnet,
An AWS Key Pair,
IAM roles created
*/


module "aviatrix-controller-build" {
  source            = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-build?ref=terraform_0.14"
  vpc               = module.vpc.vpc_id
  subnet            = module.vpc.public_subnets[0]
  keypair           = var.keypair
  ec2role           = var.ec2role
  incoming_ssl_cidr = var.incoming_ssl_cidr

}
/*
provider "aviatrix" {
  username      = var.username
  password      = module.aviatrix-controller-build.private_ip
  controller_ip = module.aviatrix-controller-build.public_ip
}

module "aviatrix-controller-initialize" {
  source              = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-initialize?ref=terraform_0.14"
  admin_password      = "<<< new admin password >>>"
  admin_email         = "<<< admin email address >>>"
  private_ip          = module.aviatrix-controller-build.private_ip
  public_ip           = module.aviatrix-controller-build.public_ip
  access_account_name = "terraform_user"
  aws_account_id      = data.aws_caller_identity.current.account_id
  vpc_id              = module.vpc.vpc_id
  subnet_id           = module.aviatrix-controller-build.subnet_id
}

output "result" {
  value = module.aviatrix-controller-initialize.result
}
*/

output "controller_private_ip" {
  value = module.aviatrix-controller-build.private_ip
}

output "controller_public_ip" {
  value = module.aviatrix-controller-build.public_ip
}
