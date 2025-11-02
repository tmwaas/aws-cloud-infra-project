output "vpc_id" {
  value = module.vpc.vpc_id
}

#output "alb_dns" {
#  value = module.alb.alb_dns_name
#}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

#output "opensearch_endpoint" {
#  value = module.observability.opensearch_endpoint
#}
