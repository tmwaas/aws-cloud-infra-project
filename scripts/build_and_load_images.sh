#!/usr/bin/env bash
set -euo pipefail
echo "Build images for minikube and load them locally using 'minikube image build' (minikube v1.30+ supports this)."
minikube image build -t demo-app:local-v1 app/v1
minikube image build -t demo-app:local-v2 app/v2
echo "Images built and stored in minikube's docker. You can now deploy the manifests or run 'skaffold dev'."
