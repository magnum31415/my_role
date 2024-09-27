#!/bin/bash

# Definir colores
verde='\033[0;32m'
rojo='\033[0;31m'
sin_color='\033[0m'  # Restablecer al color por defecto

# Define the URL to check
URL="http://localhost"

# Use curl to get the response body from the URL
response=$(curl -s $URL)

# Check if the response contains the string "Managed by Ansible"
if [[ "$response" == *"Managed by Ansible"* ]]; then
    echo -e "${verde}Check application is OK.${sin_color}"
else
    echo -e "${rojo}ERROR: Check application failed!!.${sin_color}"
fi