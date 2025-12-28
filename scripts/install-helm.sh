#!/usr/bin/env bash

set -e

echo "🚀 Installing Helm 3..."

# Download Helm installation script
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

# Make it executable
chmod 700 get_helm.sh

# Run the installation
./get_helm.sh

# Cleanup
rm get_helm.sh

# Verify installation
echo "✅ Helm installed successfully!"
helm version
