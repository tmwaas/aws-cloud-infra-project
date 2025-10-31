#!/usr/bin/env bash
set -euo pipefail
echo "This script installs Flux, ArgoCD, and Istio on Minikube (instructions)."
echo "- Install Flux CLI: https://fluxcd.io/docs/installation/"
echo "  flux install"
echo "- Install Argo CD:"
echo "  kubectl create namespace argocd || true"
echo "  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
echo "- Install Istio (using istioctl):"
echo "  istioctl install --set profile=demo -y"
echo "After installing:"
echo "1) Update flux/source.yaml and argo/app.yaml repoURL to point to your Git repo that contains this lab."
echo "2) Apply Flux GitRepository and Kustomization (or bootstrap Flux to your git host)."
