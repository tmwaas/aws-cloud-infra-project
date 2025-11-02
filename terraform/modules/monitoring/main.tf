# Prometheus
resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true
  # Uses the passed variable to find the values file in the root 'helm' folder
  values           = [file("${var.helm_values_path}/helm/prometheus-values.yaml")]
}

# Grafana
resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = "monitoring"
  # Uses the passed variable to find the values file in the root 'helm' folder
  values     = [file("${var.helm_values_path}/helm/grafana-values.yaml")]
  # Explicitly depends on Prometheus for good measure
  depends_on = [helm_release.prometheus] 
}