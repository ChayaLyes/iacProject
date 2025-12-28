# Application Source Code

## 📂 Directory Structure

Place your Node.js application code in this directory:

```
app/
└── redis-node/
    ├── main.js              # Application entry point
    ├── package.json         # Dependencies
    ├── yarn.lock           # Lock file
    └── [other source files]
```

## 🔧 Application Requirements

Your Node.js application should:

1. **Expose metrics endpoint** at `/metrics` for Prometheus
2. **Connect to Redis** using environment variables:
   - `REDIS_URL` - Master connection (writes)
   - `REDIS_REPLICAS_URL` - Replica connection (reads)
3. **Provide health endpoint** at `/health`
4. **Listen on port** defined by `PORT` env variable (default: 3000)

## 📦 Example package.json

```json
{
  "name": "redis-node",
  "version": "1.0.0",
  "main": "main.js",
  "dependencies": {
    "express": "^4.18.2",
    "redis": "^4.6.0",
    "express-prometheus-middleware": "^1.2.0"
  },
  "scripts": {
    "start": "node main.js",
    "test": "echo \"No tests yet\" && exit 0"
  }
}
```

## 🚀 Local Development

```bash
cd app/redis-node

# Install dependencies
yarn install

# Run locally (requires Redis)
export REDIS_URL=redis://localhost:6379
export REDIS_REPLICAS_URL=redis://localhost:6379
export PORT=3000

node main.js
```

## 🐳 Docker Build

The Dockerfile is located at `docker/Dockerfile` and expects the application structure above.

```bash
# Build from project root
docker build -f docker/Dockerfile -t redis-node:latest app/
```

## 📝 Notes

- Your application code is **not included** in this repository by default
- Copy your existing `redis-node/` application here
- Make sure to add `node_modules/` to `.gitignore` (already configured)
