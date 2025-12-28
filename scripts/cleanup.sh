#!/bin/bash

set -e

echo "================================================"
echo "🧹 Cleanup Script - Remove All Deployments"
echo "================================================"
echo ""

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Confirmation prompt
read -p "⚠️  This will DELETE all deployed resources. Are you sure? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "Cleanup cancelled."
    exit 0
fi

echo ""
print_warning "Starting cleanup..."
echo ""

# Delete ServiceMonitors
echo "Deleting ServiceMonitors..."
kubectl delete -f kubernetes/monitoring/ --ignore-not-found=true
print_success "ServiceMonitors deleted"

# Delete monitoring components
echo "Deleting monitoring components..."
kubectl delete deployment redis-exporter -n iacproject --ignore-not-found=true
kubectl delete svc redis-exporter -n iacproject --ignore-not-found=true
print_success "Monitoring components deleted"

# Delete Node.js application
echo "Deleting Node.js application..."
kubectl delete -f kubernetes/nodejs-app/ --ignore-not-found=true
print_success "Node.js application deleted"

# Delete Redis cluster
echo "Deleting Redis cluster..."
kubectl delete -f kubernetes/redis/ --ignore-not-found=true
print_success "Redis cluster deleted"

# Delete namespace (optional)
read -p "Delete namespace 'iacproject'? (yes/no): " delete_ns
if [ "$delete_ns" == "yes" ]; then
    kubectl delete namespace iacproject --ignore-not-found=true
    print_success "Namespace deleted"
fi

# Uninstall Prometheus (optional)
read -p "Uninstall Prometheus stack? (yes/no): " delete_prom
if [ "$delete_prom" == "yes" ]; then
    helm uninstall prometheus -n monitoring || true
    kubectl delete namespace monitoring --ignore-not-found=true
    print_success "Prometheus stack uninstalled"
fi

echo ""
echo "================================================"
print_success "Cleanup Complete!"
echo "================================================"
echo ""

# Show remaining resources
echo "Remaining pods in iacproject namespace:"
kubectl get pods -n iacproject 2>/dev/null || echo "Namespace not found (expected if deleted)"
echo ""
