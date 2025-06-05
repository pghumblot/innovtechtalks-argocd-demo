#!/bin/bash

# Stop and remove existing containers if they exist
docker rm -f color-app-orange color-app-blue 2>/dev/null

# Run the containers
echo "Starting color demo containers..."
docker run -d -p 10001:8080 -e COLOR=orange --name color-app-orange color-demo:local
docker run -d -p 10002:8080 -e COLOR=blue --name color-app-blue color-demo:local

# Display clickable links
echo -e "\nDemo applications are running!"
echo -e "\nAccess the applications at:"
echo -e "- Orange app: \033[34mhttp://localhost:10001\033[0m"
echo -e "- Blue app:   \033[34mhttp://localhost:10002\033[0m"
echo -e "\nClick the links above or copy/paste them into your browser\n"
