#!/bin/bash

set -e

echo "================================================"
echo "🚀 Automated Kubernetes Deployment Script"
echo "================================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Step 1: Check prerequisites
print_step "Checking prerequisites..."
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl not found. Please install kubectl first."
    exit 1
fi

if ! command -v helm &> /dev/null; then
    print_warning "Helm not found. Installing Helm..."
    ./scripts/install-helm.sh
fi

print_success "Prerequisites check complete"
echo ""

# Step 2: Create namespace
print_step "Creating namespace 'iacproject'..."
kubectl create namespace iacproject --dry-run=client -o yaml | kubectl apply -f -
print_success "Namespace created"
echo ""

# Step 3: Deploy Redis cluster
print_step "Deploying Redis cluster (Master + Replicas)..."
kubectl apply -f kubernetes/redis/
sleep 10
kubectl wait --for=condition=ready pod -l app=redis -n iacproject --timeout=120s
print_success "Redis cluster deployed"
echo ""

# Step 4: Deploy Node.js application
print_step "Deploying Node.js application..."
kubectl apply -f kubernetes/nodejs-app/
sleep 10
kubectl wait --for=condition=ready pod -l app=nodejs-app -n iacproject --timeout=120s
print_success "Node.js application deployed"
echo ""

# Step 5: Install Prometheus Stack with Helm
print_step "Installing Prometheus monitoring stack..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

if helm status prometheus &> /dev/null; then
    print_warning "Prometheus already installed. Skipping..."
else
    helm install prometheus prometheus-community/kube-prometheus-stack \
        --namespace monitoring \
        --create-namespace \
        --wait
    print_success "Prometheus stack installed"
fi
echo ""

# Step 6: Deploy monitoring components
print_step "Deploying Redis Exporter and ServiceMonitors..."
kubectl apply -f kubernetes/monitoring/
sleep 10
kubectl wait --for=condition=ready pod -l app=redis-exporter -n iacproject --timeout=120s
print_success "Monitoring components deployed"
echo ""

# Step 7: Display deployment status
echo "================================================"
echo "📊 Deployment Status"
echo "================================================"
echo ""

print_step "Pods in iacproject namespace:"
kubectl get pods -n iacproject
echo ""

print_step "Services in iacproject namespace:"
kubectl get svc -n iacproject
echo ""

print_step "ServiceMonitors:"
kubectl get servicemonitor -n iacproject
echo ""

# Step 8: Access instructions
echo "================================================"
echo "🎯 Access Your Services"
echo "================================================"
echo ""

print_success "Node.js Application:"
echo "  kubectl port-forward -n iacproject svc/nodejs-app 3000:3000"
echo "  Access: http://localhost:3000"
echo ""

print_success "Grafana Dashboard:"
echo "  kubectl port-forward -n monitoring svc/prometheus-grafana 3001:80"
echo "  Access: http://localhost:3001"
echo "  Default credentials: admin / prom-operator"
echo ""

print_success "Prometheus UI:"
echo "  kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090"
echo "  Access: http://localhost:9090"
echo ""

print_success "Redis Exporter Metrics:"
echo "  kubectl port-forward -n iacproject svc/redis-exporter 9121:9121"
echo "  Access: http://localhost:9121/metrics"
echo ""

echo "================================================"
echo "✅ Deployment Complete!"
echo "================================================"
