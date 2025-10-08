#!/bin/sh
# Railway provides PORT environment variable, default to 8080 if not set
export PORT=${PORT:-8080}

# Create nginx config with the PORT variable substituted
cat > /etc/nginx/conf.d/default.conf << 'EOFCONF'
server {
    listen ${PORT};
    server_name _;
    root /usr/share/nginx/html;
    index index.html;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # Compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOFCONF

# Substitute the PORT variable in the config
envsubst '${PORT}' < /etc/nginx/conf.d/default.conf > /tmp/default.conf
mv /tmp/default.conf /etc/nginx/conf.d/default.conf

# Start nginx
exec nginx -g 'daemon off;'
