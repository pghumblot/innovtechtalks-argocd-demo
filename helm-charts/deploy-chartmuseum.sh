#!/bin/bash

# Script pour déployer ChartMuseum dans le cluster Kubernetes

echo "🚀 Démarrage du déploiement de ChartMuseum..."

# Vérification que helm est installé
if ! command -v helm &> /dev/null; then
    echo "❌ Helm n'est pas installé. Veuillez installer Helm pour continuer."
    exit 1
fi

# Déploiement direct de chartmuseum depuis le dépôt
echo "⚙️  Déploiement de ChartMuseum dans le cluster..."
helm upgrade --install demo-chartmuseum https://github.com/chartmuseum/charts/releases/download/chartmuseum-3.10.4/chartmuseum-3.10.4.tgz \
  --namespace demo-chartmuseum --create-namespace \
  --set env.open.DISABLE_API=false \
  --set env.open.ALLOW_OVERWRITE=true \
  --set service.type=NodePort \
  --set service.nodePort=30100 \
  --wait \
  --timeout 5m

# Vérification du déploiement
if [ $? -ne 0 ]; then
    echo "❌ Erreur lors du déploiement de ChartMuseum"
    exit 1
fi

# 3. Ajout du repo local
echo "📦 Ajout du repo local demo-chartmuseum..."
helm repo add demo-chartmuseum http://localhost:30100
helm repo update demo-chartmuseum

echo "✅ Déploiement terminé avec succès !"
echo "ChartMuseum est accessible sur : http://localhost:30100"
echo "Pour publier des charts : helm cm-push mon-chart-0.1.0.tgz demo-chartmuseum"
