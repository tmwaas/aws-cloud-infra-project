# Istio Base
resource "helm_release" "istio_base" {
  name             = "istio-base"
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  namespace        = "istio-system"
  create_namespace = true
  # Uses the passed variable to find the values file in the root 'helm' folder
  values           = [file("${var.helm_values_path}/helm/istio-values.yaml")]
}

# Istiod
resource "helm_release" "istiod" {
  name       = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  namespace  = "istio-system"
  depends_on = [helm_release.istio_base]
  # Uses the passed variable to find the values file in the root 'helm' folder
  values     = [file("${var.helm_values_path}/helm/istio-values.yaml")]
}

# Istio Ingress Gateway
resource "helm_release" "istio_ingress" {
  name       = "istio-ingress"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  namespace  = "istio-system"
  depends_on = [helm_release.istiod]
  # Uses the passed variable to find the values file in the root 'helm' folder
  values     = [file("${var.helm_values_path}/helm/istio-values.yaml")]
}