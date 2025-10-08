# Simple Company Landing - Railway Deployment

AI Agents That Close Deals - Landing page optimized for Railway deployment.

## Features

- Clean, minimalist design with beige (#E8DFD0) background
- SIMPLE branding logo
- Responsive mobile-first layout
- Nginx static hosting with security headers
- One-click Railway deployment

## Deploy to Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new)

1. Click the button above
2. Connect your GitHub account
3. Select this repository
4. Railway will automatically detect the Dockerfile and deploy

## Local Development

```bash
# Build the Docker image
docker build -t simple-landing .

# Run locally
docker run -p 8080:8080 -e PORT=8080 simple-landing
```

Visit http://localhost:8080

## Configuration

- **PORT**: Railway automatically sets this (default: 8080)
- **Dockerfile**: Uses nginx:alpine for optimal performance
- **Security**: Includes X-Frame-Options, X-Content-Type-Options headers
- **Compression**: Gzip enabled for optimal load times

## Tech Stack

- Nginx (Alpine)
- Docker
- Railway
