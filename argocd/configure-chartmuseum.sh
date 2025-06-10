#!/bin/bash

echo "-----------------------------------------------------------"
echo "Generating ConfigMap for ArgoCD..."
echo "-----------------------------------------------------------"
echo ""
cat > chartmuseum-config.yaml <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
data:
  repositories: |
    - type: helm
      url: http://demo-chartmuseum.demo-chartmuseum.svc.cluster.local:8080
      name: demo-chartmuseum
EOF

cat chartmuseum-config.yaml
echo ""

echo "-----------------------------------------------------------"
echo "Deploying ConfigMap for ArgoCD..."
echo "-----------------------------------------------------------"
echo ""
echo "kubectl apply -f chartmuseum-config.yaml"
echo ""
kubectl apply -f chartmuseum-config.yaml
echo ""

# Cleanup config file
rm -f chartmuseum-config.yaml
