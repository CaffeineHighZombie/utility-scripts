#!/bin/bash
echo "#### Uninstallation Docker ####"
# Stop all running containers and clean up volumes
sudo docker stop $(sudo docker ps -aq)
sudo docker system prune -af --volumes
# Uninstall
sudo apt-get remove docker docker-engine docker.io containerd runc
echo "#### Docker Uninstallation Done ####"
