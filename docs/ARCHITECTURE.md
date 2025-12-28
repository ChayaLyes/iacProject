# Architecture Documentation

## Project by Chaya Lyes
DevOps Engineering Student | SAP Build Lifecycle Services Intern Candidate

---

## Table of Contents
- [System Overview](#system-overview)
- [Component Details](#component-details)
- [Data Flow](#data-flow)
- [Scaling Strategy](#scaling-strategy)
- [Monitoring & Observability](#monitoring--observability)
- [Deployment Architecture](#deployment-architecture)

---

## System Overview

This project implements a production-ready, cloud-native architecture running on Kubernetes. The system demonstrates modern DevOps practices including high availability, horizontal scalability, comprehensive observability, and full automation.

### Key Components

1. **Redis Cluster** (Master/Replica pattern)
2. **Node.js Application** (Dual Redis clients)
3. **Monitoring Stack** (Prometheus + Grafana + Redis Exporter)
4. **CI/CD Pipeline** (GitHub Actions)

---

## Component Details

### Redis Cluster

**Master/Replica Pattern**:
- Master handles all write operations
- Replicas serve read traffic
- Asynchronous replication ensures data consistency
- Horizontal scaling for read operations

**Configuration**:
- Master: 1 replica (can be StatefulSet for production)
- Replicas: 2 replicas (scalable)
- Resource limits: 512Mi RAM, 500m CPU per pod

### Node.js Application

**Dual Redis Client Pattern**:
```javascript
// Write to master
const writeClient = redis.createClient({ url: process.env.REDIS_URL });

// Read from replicas
const readClient = redis.createClient({ url: process.env.REDIS_REPLICAS_URL });
```

**Metrics Exposure**:
- `/metrics` endpoint for Prometheus
- Application performance metrics
- Resource utilization tracking

---

## Monitoring & Observability

### Prometheus Stack

**ServiceMonitors** enable automatic scraping:
- nodejs-app-monitor
- redis-exporter-monitor

**Metrics Collected**:
- HTTP request duration
- Redis memory usage
- Replication lag
- Pod resource consumption

### Grafana Dashboards

Pre-configured dashboards visualize:
1. Application performance
2. Redis cluster health
3. Kubernetes resource usage

---

## CI/CD Pipeline

GitHub Actions workflow:
1. Code checkout
2. Dependencies installation
3. Unit tests
4. Docker build
5. Push to GHCR (GitHub Container Registry)

**Registry**: `ghcr.io/chaya-lyes/redis-node:latest`

---

## Deployment Strategy

**Automated deployment** with `deploy-all.sh`:
1. Create namespace
2. Deploy Redis cluster
3. Deploy Node.js app
4. Install Prometheus stack
5. Deploy monitoring components

**One-command deployment**:
```bash
./scripts/deploy-all.sh
```

---

## Security Considerations

**Production Hardening**:
- Redis authentication with secrets
- Network policies for pod isolation
- TLS encryption for Redis
- RBAC for service accounts
- Non-root containers

---

## Author

**Chaya Lyes**  
DevOps Engineering Student  
Email: chayailyes@gmail.com  
LinkedIn: [Chaya Lyes](https://www.linkedin.com/in/chaya-lyes)  
GitHub: [@chaya-lyes](https://github.com/chaya-lyes)

---

**Last Updated**: December 2024
