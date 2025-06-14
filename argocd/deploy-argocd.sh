#!/bin/bash

# Function to display and execute a command
execute() {
    echo "  > " "$@"
    echo
    "$@"
    return $?
}

echo "----------------------------------"
echo " Adding ArgoCD Helm repository... "
echo "----------------------------------"
echo ""
unset HELM_REPOSITORY_CONFIG
execute helm repo add argo https://argoproj.github.io/argo-helm
execute helm repo update argo
echo ""

echo "----------------------"
echo " Installing ArgoCD... "
echo "----------------------"
echo ""
execute helm upgrade --install argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace \
  --version 5.51.4 \
  --set server.service.type=NodePort \
  --set server.service.nodePortHttp=30080 \
  --wait \
  --timeout 5m
echo ""
