# 🚀 Quick Start Guide - Chaya Lyes

## ✅ Fichiers créés avec succès !

Tous les fichiers de ton projet ont été créés et organisés professionnellement avec **tes informations personnelles**.

---

## 📂 Structure complète créée

```
iacProject/
├── .github/workflows/
│   └── docker-build.yml          ✅ CI/CD pipeline
├── ansible/
│   ├── inventory                 ✅ Configuration Ansible
│   └── playbook.yml              ✅ Installation automatique des outils
├── kubernetes/
│   ├── redis/
│   │   ├── redis-master.yaml     ✅ Redis Master
│   │   └── redis-replica.yaml    ✅ Redis Replicas
│   ├── nodejs-app/
│   │   ├── deployment.yaml       ✅ Déploiement Node.js
│   │   └── service.yaml          ✅ Service Kubernetes
│   └── monitoring/
│       ├── redis-exporter.yaml         ✅ Exporter Redis
│       ├── redis-servicemonitor.yaml   ✅ ServiceMonitor Redis
│       └── nodejs-servicemonitor.yaml  ✅ ServiceMonitor Node.js
├── docker/
│   └── Dockerfile                ✅ Image Docker optimisée
├── app/
│   └── README.md                 ✅ Instructions pour l'app
├── scripts/
│   ├── install-helm.sh           ✅ Installation Helm
│   ├── deploy-all.sh             ✅ Déploiement automatique
│   └── cleanup.sh                ✅ Script de nettoyage
├── docs/
│   └── ARCHITECTURE.md           ✅ Documentation complète
├── .gitignore                    ✅ Fichiers à ignorer
├── LICENSE                       ✅ Licence MIT
└── README.md                     ✅ Documentation principale
```

---

## 📋 PROCHAINES ÉTAPES

### Étape 1 : Extraire l'archive sur ta VM

```bash
cd ~
tar -xzf iacProject-complete.tar.gz
cd iacProject
```

### Étape 2 : Copier ton application Node.js

```bash
# Trouve ton ancien code redis-node
find ~ -name "redis-node" -type d 2>/dev/null

# Copie-le dans le nouveau projet
cp -r /chemin/vers/ton/ancien/redis-node ~/iacProject/app/
```

### Étape 3 : Rendre les scripts exécutables

```bash
cd ~/iacProject
chmod +x scripts/*.sh
```

### Étape 4 : Configurer Git avec tes informations

```bash
# Configure ton nom et email
git config --global user.name "Chaya Lyes"
git config --global user.email "chayailyes@gmail.com"
```

### Étape 5 : Pousser vers GitHub

```bash
cd ~/iacProject

# Initialiser Git
git init

# Ajouter tous les fichiers
git add .

# Commit
git commit -m "Initial commit: Automated Kubernetes Infrastructure Project

- Redis cluster (master/replica pattern)
- Node.js application with dual Redis clients
- Monitoring stack (Prometheus, Grafana, Redis Exporter)
- CI/CD pipeline with GitHub Actions
- Infrastructure as Code with Kubernetes manifests
- Ansible playbooks for DevOps tools installation
- Complete documentation and architecture guide"

# Ajouter le remote
git remote add origin https://github.com/chaya-lyes/iacProject.git

# Pousser vers GitHub (force car le repo existe déjà)
git branch -M main
git push -u origin main --force
```

### Étape 6 : Déployer le projet

```bash
# Déploiement automatique en une commande !
./scripts/deploy-all.sh
```

---

## 🌐 Accéder aux services

```bash
# Application Node.js
kubectl port-forward -n iacproject svc/nodejs-app 3000:3000
# → http://localhost:3000

# Grafana
kubectl port-forward -n monitoring svc/prometheus-grafana 3001:80
# → http://localhost:3001
# Credentials: admin / prom-operator

# Prometheus
kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090
# → http://localhost:9090
```

---

## 🧪 Tester le CI/CD

Une fois que tu as poussé vers GitHub, le workflow CI/CD se déclenchera automatiquement :

1. ✅ Installation des dépendances
2. ✅ Exécution des tests
3. ✅ Build de l'image Docker
4. ✅ Push vers GitHub Container Registry

Vois le statut ici : https://github.com/chaya-lyes/iacProject/actions

---

## 🧹 Nettoyer les déploiements

```bash
./scripts/cleanup.sh
```

---

## 📚 Documentation

- **README.md** : Documentation principale du projet
- **docs/ARCHITECTURE.md** : Architecture détaillée et explications techniques
- **app/README.md** : Instructions pour l'application Node.js

---

## 🎓 Pour les entretiens SAP

Ce projet démontre :
- ✅ Orchestration de containers avec Kubernetes
- ✅ Patterns haute disponibilité (Master/Replica)
- ✅ Monitoring et observabilité (Prometheus/Grafana)
- ✅ CI/CD avec GitHub Actions
- ✅ Infrastructure as Code
- ✅ Automatisation DevOps
- ✅ Documentation professionnelle

**Points à mentionner en entretien** :
- Architecture master/replica pour Redis
- Séparation read/write pour performance
- ServiceMonitors pour auto-découverte Prometheus
- Pipeline CI/CD automatisé
- Scalabilité horizontale

---

## ✅ Checklist finale

- [ ] Archive extraite dans `~/iacProject`
- [ ] Application Node.js copiée dans `app/redis-node/`
- [ ] Scripts rendus exécutables (`chmod +x scripts/*.sh`)
- [ ] Git configuré avec tes informations
- [ ] Code poussé vers GitHub
- [ ] CI/CD workflow vérifié
- [ ] Déploiement testé avec `./scripts/deploy-all.sh`
- [ ] Services accessibles (port-forward)

---

## 🆘 Besoin d'aide ?

Si tu rencontres un problème :
1. Vérifie les logs : `kubectl logs -n iacproject <pod-name>`
2. Regarde le statut : `kubectl get pods -n iacproject`
3. Consulte la documentation : `docs/ARCHITECTURE.md`

---

**Bon courage pour ton portfolio et tes entretiens SAP ! 🚀**

**Author**: Chaya Lyes  
**Email**: chayailyes@gmail.com  
**LinkedIn**: [Chaya Lyes](https://www.linkedin.com/in/chaya-lyes)
