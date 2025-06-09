#!/bin/bash

set -euo pipefail

# Configuration
CHARTMUSEUM_URL="http://localhost:30100"
CHARTS=("color-app" "config-map" "super-color-app-v2" "super-multicolor-app")

echo "-----------------------------------------------------------"
echo "Packaging and uploading charts to $CHARTMUSEUM_URL"
echo "-----------------------------------------------------------"
echo ""

# Crée un environnement Helm isolé
TMP_HELM_HOME=$(mktemp -d)
export HELM_REPOSITORY_CONFIG="$TMP_HELM_HOME/repositories.yaml"
export HELM_REPOSITORY_CACHE="$TMP_HELM_HOME/repository"

# Ajoute uniquement demo-chartmuseum
helm repo add demo-chartmuseum "$CHARTMUSEUM_URL" > /dev/null
helm repo update > /dev/null

for chart in "${CHARTS[@]}"; do
  if [ ! -d "$chart" ]; then
    echo "❌ Chart directory '$chart' not found. Skipping."
    continue
  fi

  echo "➡️  Packaging chart: $chart"

  # 🔄 Build dependencies s’il y en a
  if grep -q "dependencies:" "$chart/Chart.yaml"; then
    echo "🔄 Building Helm dependencies for $chart"
    helm dependency build "$chart"
  fi

  helm package "$chart" --destination "$TMP_HELM_HOME"

  PACKAGE_FILE=$(ls "$TMP_HELM_HOME"/${chart}-*.tgz | sort -V | tail -n 1)

  echo "🚀 Uploading $PACKAGE_FILE to ChartMuseum..."
  curl --fail --silent --show-error \
    --data-binary "@$PACKAGE_FILE" \
    "$CHARTMUSEUM_URL/api/charts"

  echo "✅ Uploaded: $PACKAGE_FILE"
done

echo "🧹 Cleaning up..."
rm -rf "$TMP_HELM_HOME"

echo "🎉 All done."
