module "this" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.2.0"

  name = "tmw-vpc"
  cidr = var.cidr
  azs  = var.azs

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "tmw-vpc"
    Environment = "dev"
    Terraform   = "true"
  }
}

