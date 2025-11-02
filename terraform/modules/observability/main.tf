
# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "app" {
  name              = var.cloudwatch_log_group_name
  retention_in_days = 14
}

# OpenSearch Domain
resource "aws_opensearch_domain" "app_logs" {
  domain_name = var.opensearch_domain_name

  cluster_config {
    instance_type = "t3.small.search"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  engine_version = "OpenSearch_1.3"

  access_policies = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = "*",
      Action = "es:*",
      Resource = "*"
    }]
  })
}

# Prometheus & Grafana via Helm (requires helm provider configured)
resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "45.6.0"

  timeout = 600
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "9.13.0"
  timeout = 300
  values = [
    yamlencode({
      adminUser = "admin"
      adminPassword = "admin"
      persistence = { enabled = false }
    })
  ]
  depends_on = [helm_release.kube_prometheus_stack]
}

output "opensearch_endpoint" {
  value = aws_opensearch_domain.app_logs.endpoint
}

output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.app.name
}
