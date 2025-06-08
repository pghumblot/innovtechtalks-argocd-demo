#!/bin/bash

# Create cluster
echo "Creating demo cluster..." 
echo "kind create cluster --name demo-cluster"
echo ""
kind create cluster --name demo-cluster

# Wait for cluster to be ready
sleep 1

# Load docker image
echo ""
echo "-----------------------"
echo "Loading docker image..."
echo "kind load docker-image color-demo:local --name demo-cluster"
kind load docker-image color-demo:local --name demo-cluster