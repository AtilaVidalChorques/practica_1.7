#!/bin/bash
# Script: setup_letsencrypt_https.sh

# --- Variables de Configuración (Reemplazar) ---
DOMAIN="practica-wordpress.test"     
EMAIL="webmaster@practica-wordpress.test"

echo "Iniciando configuración HTTPS con Certbot..."

# Instalación de Certbot (para Debian/Ubuntu)
if command -v apt > /dev/null; then
    sudo apt update
    sudo apt install -y certbot python3-certbot-apache
else
    echo "Error: Instala Certbot manualmente."
    exit 1
fi

# Obtención y configuración del certificado
echo "Ejecutando Certbot para $DOMAIN..."
sudo certbot --apache \
    -d "$DOMAIN" \
    -n \
    --agree-tos \
    -m "$EMAIL" \
    --redirect \
    --hsts \
    --staple-ocsp

if [ $? -eq 0 ]; then
    echo "Certificado obtenido y configurado exitosamente."
else
    echo "Error: Certbot falló."
    exit 1
fi

# Comprobación de renovación
sudo certbot renew --dry-run

echo "Configuración HTTPS completada."
