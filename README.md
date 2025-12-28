# 🚀 Automated Kubernetes Infrastructure Project

[![CI/CD Pipeline](https://github.com/chaya-lyes/iacProject/actions/workflows/docker-build.yml/badge.svg)](https://github.com/chaya-lyes/iacProject/actions)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=flat&logo=prometheus&logoColor=white)](https://prometheus.io/)

> **Production-ready Kubernetes architecture** with Redis cluster, Node.js application, and comprehensive monitoring stack - **fully automated deployment**.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Monitoring & Observability](#monitoring--observability)
- [CI/CD Pipeline](#cicd-pipeline)

---

## 🎯 Overview

This project demonstrates a **complete DevOps workflow** featuring:
- High-availability Redis cluster (master/replica pattern)
- Scalable Node.js web application
- Production-grade monitoring with Prometheus & Grafana
- Automated CI/CD pipeline with GitHub Actions
- Infrastructure as Code with Kubernetes manifests
- Configuration management with Ansible

**Perfect for demonstrating DevOps skills in interviews and technical portfolios.**

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Kubernetes Cluster                        │
│                                                              │
│  ┌──────────────┐      ┌─────────────────┐                 │
│  │   Node.js    │─────▶│  Redis Master   │                 │
│  │     App      │      │   (Writes)      │                 │
│  │              │      └─────────────────┘                 │
│  │              │              │                            │
│  │              │              │ Replication                │
│  │              │              ▼                            │
│  │              │      ┌─────────────────┐                 │
│  │              │─────▶│ Redis Replicas  │                 │
│  └──────────────┘      │    (Reads)      │                 │
│         │              └─────────────────┘                 │
│         │                                                   │
│         │ /metrics                                          │
│         ▼                                                   │
│  ┌──────────────────────────────────────┐                  │
│  │         Prometheus Stack              │                  │
│  │  ┌──────────┐  ┌─────────────────┐  │                  │
│  │  │Prometheus│  │ Redis Exporter  │  │                  │
│  │  └──────────┘  └─────────────────┘  │                  │
│  │       │                               │                  │
│  │       ▼                               │                  │
│  │  ┌──────────┐                        │                  │
│  │  │ Grafana  │  (Dashboards)          │                  │
│  │  └──────────┘                        │                  │
│  └──────────────────────────────────────┘                  │
└─────────────────────────────────────────────────────────────┘
```

### Component Interactions

1. **Redis Cluster**: Master handles writes, replicas serve read traffic (horizontal scaling)
2. **Node.js App**: Dual Redis clients for optimal read/write separation
3. **Monitoring**: Prometheus scrapes metrics from app + Redis Exporter
4. **Observability**: Grafana visualizes all metrics with pre-configured dashboards

---

## ✨ Features

### Infrastructure
- ✅ **Redis HA Cluster**: Master/replica architecture with automatic replication
- ✅ **Kubernetes Native**: All resources deployed as K8s manifests
- ✅ **Service Discovery**: Automatic service registration and load balancing
- ✅ **Scalable Architecture**: Horizontal pod autoscaling ready

### Monitoring
- ✅ **Prometheus**: Metrics collection with ServiceMonitor CRDs
- ✅ **Grafana**: Real-time dashboards for app and infrastructure metrics
- ✅ **Redis Exporter**: Native Redis metrics exposure
- ✅ **Custom Metrics**: Application performance monitoring (APM)

### DevOps Automation
- ✅ **CI/CD Pipeline**: GitHub Actions for Docker build & push
- ✅ **Infrastructure as Code**: Declarative Kubernetes manifests
- ✅ **Ansible Playbooks**: Automated tooling installation
- ✅ **One-Command Deploy**: Complete stack deployment with single script

---

## 🛠️ Tech Stack

| Category | Technologies |
|----------|-------------|
| **Container Orchestration** | Kubernetes, Minikube |
| **Containerization** | Docker, GHCR |
| **Application** | Node.js 18, Express.js |
| **Database** | Redis (Master/Replica) |
| **Monitoring** | Prometheus, Grafana, Redis Exporter |
| **CI/CD** | GitHub Actions |
| **IaC** | Kubernetes YAML, Helm Charts |
| **Configuration Management** | Ansible |
| **Package Management** | Helm, npm/yarn |

---

## 📦 Prerequisites

Before starting, ensure you have:

```bash
# Required tools
- Kubernetes cluster (Minikube/Kind/K3s)
- kubectl CLI (v1.24+)
- Docker (v20.10+)
- Helm 3
- Git

# Optional (for Ansible automation)
- Ansible 2.9+
```

### Installation Check
```bash
kubectl version --client
docker --version
helm version
```

---

## 🚀 Quick Start

### Option 1: Automated Deployment (Recommended)

```bash
# 1. Clone the repository
git clone https://github.com/chaya-lyes/iacProject.git
cd iacProject

# 2. Make scripts executable
chmod +x scripts/*.sh

# 3. Deploy everything (one command!)
./scripts/deploy-all.sh
```

### Option 2: Manual Step-by-Step

```bash
# 1. Install Helm
./scripts/install-helm.sh

# 2. Deploy Redis cluster
kubectl apply -f kubernetes/redis/

# 3. Deploy Node.js application
kubectl apply -f kubernetes/nodejs-app/

# 4. Deploy monitoring stack
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack

# 5. Deploy ServiceMonitors
kubectl apply -f kubernetes/monitoring/
```

### Access Services

```bash
# Node.js Application
kubectl port-forward -n iacproject svc/nodejs-app 3000:3000
# Access: http://localhost:3000

# Grafana Dashboard
kubectl port-forward svc/prometheus-grafana 3001:80
# Access: http://localhost:3001
# Default credentials: admin / prom-operator

# Prometheus UI
kubectl port-forward svc/prometheus-kube-prometheus-prometheus 9090:9090
# Access: http://localhost:9090
```

---

## 📁 Project Structure

```
iacProject/
├── .github/workflows/
│   └── docker-build.yml          # CI/CD pipeline for Docker images
├── ansible/
│   ├── inventory                 # Ansible hosts configuration
│   └── playbook.yml              # DevOps tools installation playbook
├── kubernetes/
│   ├── redis/
│   │   ├── redis-master.yaml     # Redis master deployment
│   │   └── redis-replica.yaml    # Redis replica deployment
│   ├── nodejs-app/
│   │   ├── deployment.yaml       # Node.js app deployment
│   │   └── service.yaml          # Service exposition
│   └── monitoring/
│       ├── redis-exporter.yaml         # Redis metrics exporter
│       ├── redis-servicemonitor.yaml   # Prometheus scrape config
│       └── nodejs-servicemonitor.yaml  # App metrics scrape config
├── docker/
│   └── Dockerfile                # Multi-stage Node.js image
├── app/
│   └── redis-node/               # Node.js application source
│       ├── main.js
│       └── package.json
├── scripts/
│   ├── install-helm.sh           # Helm installation script
│   ├── deploy-all.sh             # Full deployment automation
│   └── cleanup.sh                # Cleanup script
├── docs/
│   └── ARCHITECTURE.md           # Detailed architecture documentation
└── README.md                     # This file
```

---

## 📊 Monitoring & Observability

### Metrics Collected

**Application Metrics** (via `/metrics` endpoint):
- HTTP request duration & count
- CPU usage
- Memory consumption
- Event loop lag
- Active connections

**Redis Metrics** (via Redis Exporter):
- Memory usage
- Command throughput
- Replication lag
- Connected clients
- Key space statistics

### Grafana Dashboards

Access pre-configured dashboards for:
1. **Node.js Application Performance**
2. **Redis Cluster Health**
3. **Kubernetes Resource Usage**

---

## 🔄 CI/CD Pipeline

The GitHub Actions workflow automates:
1. ✅ Code checkout
2. ✅ Node.js dependencies installation (with Yarn cache)
3. ✅ Unit tests execution
4. ✅ Docker image build
5. ✅ Push to GitHub Container Registry (GHCR)
6. ✅ Automatic tagging (`latest`)

**Trigger**: Push to `main` branch

View workflow: `.github/workflows/docker-build.yml`

---

## 🎓 Learning Objectives

This project demonstrates proficiency in:
- Container orchestration with Kubernetes
- High-availability database patterns
- Microservices architecture
- Observability and monitoring
- CI/CD automation
- Infrastructure as Code
- Configuration management
- DevOps best practices

---

## 📝 License

This project is open source and available under the MIT License.

---

## 👤 Author

**Chaya Lyes**  
DevOps Engineering Student | SAP Build Lifecycle Services Intern Candidate

📧 Email: chayailyes@gmail.com  
🔗 LinkedIn: [Chaya Lyes](https://www.linkedin.com/in/chaya-lyes)  
💻 GitHub: [@chaya-lyes](https://github.com/chaya-lyes)

---

## 🙏 Acknowledgments

- Prometheus Community for kube-prometheus-stack
- Oliver006 for Redis Exporter
- Kubernetes community for excellent documentation

---

**⭐ If this project helped you, please consider giving it a star!**
