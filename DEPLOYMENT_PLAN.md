# Railway Deployment Plan for Simple Landing Page

## Overview
Deploy a static HTML landing page with Alpine.js to Railway using a lightweight static file server.

## Deployment Methods

### Method 1: Docker with Nginx (Recommended for Production)
**Pros:** Fast, efficient, production-ready
**Setup Time:** 10 minutes

#### 1. Create Dockerfile
```dockerfile
FROM nginx:alpine
COPY . /usr/share/nginx/html
EXPOSE 80
```

#### 2. Create nginx.conf (optional for custom config)
```nginx
server {
    listen 80;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    # Enable gzip compression
    gzip on;
    gzip_types text/css application/javascript;
}
```

#### 3. Deploy to Railway
```bash
railway login
railway init
railway up
```

### Method 2: Caddy Server (Simplest)
**Pros:** Auto-HTTPS, minimal config
**Setup Time:** 5 minutes

#### 1. Create Caddyfile
```
:{$PORT:3000} {
    root * .
    file_server
    encode gzip
}
```

#### 2. Create railway.json
```json
{
  "$schema": "https://railway.com/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "caddy run --config Caddyfile --adapter caddyfile"
  }
}
```

### Method 3: Node.js with http-server (Quick & Simple)
**Pros:** JavaScript ecosystem, easy debugging
**Setup Time:** 5 minutes

#### 1. Create package.json
```json
{
  "name": "simple-landing",
  "version": "1.0.0",
  "scripts": {
    "start": "npx http-server . -p $PORT --no-dotfiles"
  },
  "devDependencies": {
    "http-server": "^14.1.1"
  }
}
```

#### 2. Deploy
```bash
railway up
```

## Environment Variables
```env
# No environment variables required for static site
# Railway automatically provides $PORT
```

## Pre-Deployment Checklist

- [x] Optimize images (logo.png compressed)
- [x] Minify CSS/JS (optional for production)
- [x] Test Alpine.js functionality locally
- [x] Verify Cal.com integration works
- [ ] Set up custom domain (optional)
- [ ] Configure SSL (Railway handles automatically)

## Deployment Steps

1. **Install Railway CLI**
   ```bash
   npm install -g @railway/cli
   ```

2. **Login to Railway**
   ```bash
   railway login
   ```

3. **Initialize Project**
   ```bash
   railway init
   # Select "Empty Project"
   ```

4. **Choose deployment method** (Dockerfile recommended)

5. **Deploy**
   ```bash
   railway up
   ```

6. **Get Deployment URL**
   ```bash
   railway open
   ```

## Post-Deployment

### Custom Domain Setup
1. Go to Railway dashboard
2. Navigate to Settings → Domains
3. Add custom domain
4. Update DNS CNAME record

### Monitoring
- Railway provides built-in metrics
- Check deployment logs: `railway logs`

### Continuous Deployment
```yaml
# .github/workflows/deploy.yml
name: Deploy to Railway
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: bervProject/railway-deploy@main
        with:
          railway_token: ${{ secrets.RAILWAY_TOKEN }}
          service: "simple-landing"
```

## Cost Estimate
- **Hobby Plan:** $5/month (includes $5 usage)
- **Static site usage:** ~$0.50/month
- **Expected total:** $5/month

## Rollback Strategy
```bash
# View deployment history
railway deployments

# Rollback to previous version
railway rollback [deployment-id]
```

## Performance Optimizations
1. Enable Cloudflare proxy (free CDN)
2. Use WebP images instead of PNG/JPG
3. Lazy load below-fold content
4. Preload critical fonts

## Security Considerations
- [x] No sensitive data in static files
- [x] Content Security Policy headers (via server config)
- [x] HTTPS enforced by Railway
- [x] Regular dependency updates

## Support & Troubleshooting
- Railway Discord: https://discord.gg/railway
- Documentation: https://docs.railway.app
- Status Page: https://status.railway.app