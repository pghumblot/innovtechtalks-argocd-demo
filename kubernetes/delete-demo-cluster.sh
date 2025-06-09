#!/bin/bash

echo "------------------------------------------"
echo "Deleting local Kubernetes demo cluster..."
echo "------------------------------------------"
echo ""
echo "kind delete cluster --name demo-cluster"
echo ""
kind delete cluster --name demo-cluster
echo ""