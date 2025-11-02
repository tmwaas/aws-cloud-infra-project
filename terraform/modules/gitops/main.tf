# ArgoCD
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  # Uses the passed variable to find the values file in the root 'helm' folder
  values           = [file("${var.helm_values_path}/helm/argocd-values.yaml")]
}

# FluxCD
resource "helm_release" "fluxcd" {
  name             = "fluxcd"
  repository       = "https://fluxcd-community.github.io/helm-charts"
  chart            = "flux2"
  namespace        = "flux-system"
  create_namespace = true
  # Uses the passed variable to find the values file in the root 'helm' folder
  values           = [file("${var.helm_values_path}/helm/fluxcd-values.yaml")]
}