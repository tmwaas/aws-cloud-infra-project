
variable "region" {
  type = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "eks_cluster_name" {
  type = string
  default = "tmw-cloud-eks"
}

variable "kubeconfig_path" {
  type = string
  default = "~/.kube/config"
}

variable "cloudwatch_log_group_name" {
  type = string
  default = "/ecs/aws-cloud-app"
}

variable "opensearch_domain_name" {
  type = string
  default = "aws-cloud-app-logs"
}
