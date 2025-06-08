#!/bin/bash

# Create Kind cluster configuration
echo "Creating Kind cluster configuration..."
cat > kind-config.yaml <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 30001
        hostPort: 30001
      - containerPort: 30002
        hostPort: 30002
      - containerPort: 30005
        hostPort: 30005
      - containerPort: 30100
        hostPort: 30100
EOF

# Create cluster
echo "Creating demo-cluster with port mappings..."
echo "kind create cluster --name demo-cluster --config=kind-config.yaml"
kind create cluster --name demo-cluster --config=kind-config.yaml

# Cleanup config file
rm -f kind-config.yaml


# Wait for cluster to be ready
sleep 1

# Load docker image
echo ""
echo "-----------------------"
echo "Loading docker image..."
echo "kind load docker-image color-demo:local --name demo-cluster"
kind load docker-image color-demo:local --name demo-cluster