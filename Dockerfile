FROM nginx:alpine

# Copy the HTML file to nginx html directory
COPY index.html /usr/share/nginx/html/index.html

# Copy startup script
COPY start-nginx.sh /start-nginx.sh
RUN chmod +x /start-nginx.sh

# Railway will set PORT environment variable
ENV PORT=8080

# Run startup script
CMD ["/start-nginx.sh"]
