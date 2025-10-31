#!/usr/bin/env bash
set -euo pipefail
echo "This script initializes a local git repo (if not present) and shows a flux bootstrap command."
echo "1) Initialize git repo and push to GitHub (example):"
echo "   git init"
echo "   git add ."
echo "   git commit -m 'flux-argocd-istio-lab'"
echo "   git remote add origin git@github.com:YOUR_USER/YOUR_REPO.git"
echo "   git push -u origin main"
echo ""
echo "2) Bootstrap Flux (example):"
echo "flux bootstrap github \
  --owner=YOUR_USER \
  --repository=YOUR_REPO \
  --branch=main \
  --path=./ \
  --personal"
