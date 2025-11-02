terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.15.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
  required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.region
}

# ───────────────────────────────
# VPC Module
# ───────────────────────────────
module "vpc" {
  source = "./modules/vpc"

  region          = var.region
  cidr            = var.vpc_cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# ───────────────────────────────
# IAM Module
# ───────────────────────────────
module "iam" {
  source = "./modules/iam"
  region = var.region
}

# ───────────────────────────────
# Application Load Balancer
# ───────────────────────────────
module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

# ───────────────────────────────
# EKS Cluster (fixed syntax for v21.8.0)
# ───────────────────────────────
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.8.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.30"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = concat(module.vpc.public_subnets, module.vpc.private_subnets)

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 1
    }
  }

  enable_irsa = true
}

# ───────────────────────────────
# Providers (connect to EKS)
# ───────────────────────────────
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster.name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster.name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

# ───────────────────────────────
# ECS Module (Optional)
# ───────────────────────────────
module "ecs" {
  source                    = "./modules/ecs"
  vpc_id                    = module.vpc.vpc_id
  public_subnets            = module.vpc.public_subnets
  ecs_task_execution_arn    = module.iam.ecs_task_execution_arn
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  region                    = var.region
}

# ───────────────────────────────
# Observability Stack
# ───────────────────────────────
module "observability" {
  source = "./modules/observability"

  region                    = var.region
  cluster_name              = module.eks.cluster.name
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  opensearch_domain_name    = var.opensearch_domain_name
}
