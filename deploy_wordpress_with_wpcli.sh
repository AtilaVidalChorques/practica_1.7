#!/bin/bash
# Script: deploy_wordpress_with_wpcli.sh

# --- Variables de Configuración (REEMPLAZAR con tus valores) ---
# Credenciales de MySQL
DB_NAME="wordpress_db"
DB_USER="wordpress_user"
DB_PASSWORD="your_db_password"
DB_HOST="localhost"
MYSQL_ROOT_PASSWORD="your_mysql_root_password" # <<< Contraseña de root de MySQL

# Parámetros de instalación de WordPress
WP_URL="practica-wordpress.test"
WP_TITLE="Mi Sitio Web con WP-CLI"
WP_ADMIN_USER="wp_admin"
WP_ADMIN_PASSWORD="your_admin_password" 
WP_ADMIN_EMAIL="admin@practica-wordpress.test"
WP_LOCALE="es_ES"
WP_PATH="/var/www/html"

echo "Iniciando despliegue de WordPress con WP-CLI..."

# 1. Instalación de WP-CLI
echo "1. Instalando WP-CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# 2. Creación de la Base de Datos y Usuario en MySQL
echo "2. Creando Base de Datos y Usuario en MySQL..."
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$DB_USER'@'$DB_HOST' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'$DB_HOST';"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# 3. Preparación del Directorio y Descarga de WordPress
echo "3. Preparando directorio y descargando WordPress..."
sudo mkdir -p $WP_PATH
sudo chown -R www-data:www-data $WP_PATH
sudo chmod -R 755 $WP_PATH

sudo wp core download \
    --locale=$WP_LOCALE \
    --path=$WP_PATH \
    --allow-root

# 4. Creación de wp-config.php
echo "4. Creando wp-config.php..."
sudo wp config create \
    --dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$DB_PASSWORD \
    --dbhost=$DB_HOST \
    --path=$WP_PATH \
    --allow-root

# 5. Instalación de WordPress
echo "5. Instalando el Core de WordPress..."
sudo wp core install \
    --url=$WP_URL \
    --title="$WP_TITLE" \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --path=$WP_PATH \
    --allow-root \
    --skip-email

# 6. Ajuste final de permisos (Paso 6 de la guía)
echo "6. Ajustando permisos finales a www-data..."
sudo chown -R www-data:www-data $WP_PATH

# 7. Configuración de Enlaces Permanentes (Paso 7 de la guía)
echo "7. Configurando enlaces permanentes..."
sudo wp rewrite structure '/%postname%/' \
    --path=$WP_PATH \
    --allow-root
sudo wp rewrite flush --path=$WP_PATH --allow-root

echo "Despliegue de WordPress completado. URL: $WP_URL"
