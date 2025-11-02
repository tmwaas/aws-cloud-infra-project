
variable "region" { type = string }
variable "cloudwatch_log_group_name" { type = string }
variable "opensearch_domain_name" { type = string }

variable "cluster_name" {
  description = "EKS cluster name for observability setup"
  type        = string
}