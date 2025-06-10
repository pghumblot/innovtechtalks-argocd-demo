#!/bin/bash

# Create Kind cluster configuration
echo "-----------------------------------------------------------"
echo "Generating Kind cluster configuration for ports mappings..."
echo "-----------------------------------------------------------"
echo ""
cat > kind-config.yaml <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:

      # Color app ports
      - containerPort: 30001
        hostPort: 30001
      - containerPort: 30002
        hostPort: 30002
      - containerPort: 30005
        hostPort: 30005

      # ChartMuseum ports
      - containerPort: 30100
        hostPort: 30100

      # ArgoCD ports
      - containerPort: 30080
        hostPort: 30080

EOF
cat kind-config.yaml
echo ""

# Create cluster
echo "-----------------------------------------------------------"
echo "Deploying local Kubernetes demo cluster..."
echo "-----------------------------------------------------------"
echo ""
echo "kind create cluster --name demo-cluster --config=kind-config.yaml"
echo ""
kind create cluster --name demo-cluster --config=kind-config.yaml
echo ""

# Cleanup config file
rm -f kind-config.yaml

# Wait for cluster to be ready
sleep 1

# Load docker image
echo "-----------------------------------------------------------"
echo "Loading docker image..."
echo "-----------------------------------------------------------"
echo ""
echo "kind load docker-image color-demo:local --name demo-cluster"
echo ""
kind load docker-image color-demo:local --name demo-cluster
echo ""

# Create app namespace
kubectl create namespace app >/dev/null 2>&1
