#!/bin/bash

# Function to display and execute a command
execute() {
    echo "  > " "$@"
    echo
    "$@"
    return $?
}

# Deploying ChartMuseum
echo "---------------------------------------------"
echo " Deploying ChartMuseum to the cluster..."
echo "---------------------------------------------"
echo

execute helm upgrade --install demo-chartmuseum \
  https://github.com/chartmuseum/charts/releases/download/chartmuseum-3.10.4/chartmuseum-3.10.4.tgz \
  --namespace demo-chartmuseum \
  --create-namespace \
  --set env.open.DISABLE_API=false \
  --set env.open.ALLOW_OVERWRITE=true \
  --set service.type=NodePort \
  --set service.nodePort=30100 \
  --wait \
  --timeout 5m
echo ""

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to deploy ChartMuseum"
    echo "For debugging, you can check the logs with:"
    echo "  kubectl logs -n demo-chartmuseum -l app=chartmuseum"
    exit 1
fi

# Configuring local Helm repository
echo "----------------------------------------"
echo "Configuring local Helm repository..."
echo "----------------------------------------"
unset HELM_REPOSITORY_CONFIG
echo "1. Adding 'demo-chartmuseum' repository..."
execute helm repo add demo-chartmuseum http://localhost:30100

echo "2. Updating repository cache..."
execute helm repo update demo-chartmuseum
echo ""

# Vérification de l'ajout du dépôt
if ! helm repo list | grep -q "demo-chartmuseum"; then
    echo "Warning: Unable to verify repository addition"
fi

# Displaying completion information
echo "-----------------------"
echo "DEPLOYMENT SUCCESSFUL!"
echo "-----------------------"
echo ""
echo "ChartMuseum is now available:"
echo "   - Web interface: http://localhost:30100"
echo ""
