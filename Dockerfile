FROM nginx:latest

# Copy index.html file from the local directory to the default NGINX directory
COPY manifest/index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
