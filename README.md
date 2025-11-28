# Instalación de WP-CLI en el servidor LAMP

Descargamos el archivo wp-cli.phar del repositorio oficial de WP-CLI con el comando 
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
Ademas de asignar permisos de ejecución al archivo wp-cli.phar.
chmod +x wp-cli.phar
Y por ultimo Movemos el archivo wp-cli.phar al directorio /usr/local/bin/ con el nombre wp para poder utilizarlo sin necesidad de escribir la ruta completa donde se encuentra.
sudo mv wp-cli.phar /usr/local/bin/wp

<img width="792" height="151" alt="image" src="https://github.com/user-attachments/assets/76892b60-9ffd-4ede-83b8-56f646c9dce1" />

# Paso 1. Descarga del código fuente de WordPress

Para descargar el código fuente de WordPress con el comando wp core download podemos hacerlo situándonos en el directorio donde queremos realizar la instalación de WordPress. En mi caso sera en /var/www/html, una vez dentro usaremos el comando.

<img width="667" height="516" alt="image" src="https://github.com/user-attachments/assets/6b67dade-f6bc-4b24-ad5b-dcdcb29f2dc0" />

# Paso 2. Creación de la base datos, usuario y contraseña en MySQL Server

Yo ya tenia la base de datos creada, el usuarios y la contraseña creadas de la practica anterior así que este paso lo podemos saltar.

# Paso 3. Creación del archivo de configuración

Ya lo teníamos instalado de antes por eso nos sale que ya existe.

<img width="846" height="103" alt="image" src="https://github.com/user-attachments/assets/77522aad-fd9a-44d5-89fa-b2870afc3a96" />

# Paso 4. Comprobación de los valores del archivo de configuración (wp config get)

Podemos comprobar los valores del archivo de configuración del archivo wp-config.php con el comando wp config get:

<img width="565" height="421" alt="image" src="https://github.com/user-attachments/assets/bb028301-5ff9-4cd4-9dc2-3dc28db62b34" />

# Paso 5. Instalación de WordPress (wp core install)

Una vez que tenemos la base de datos creada y el archivo de configuración preparado podemos realizar la instalación de WordPress con el comando:

<img width="842" height="249" alt="image" src="https://github.com/user-attachments/assets/fcd814f9-b085-4328-a227-22688d0eb955" />

# Paso 6. Modificación del propietario y grupo del directorio /var/www/html

Como hemos estado ejecutando el comando wp como sudo, el contenido del directorio /var/www/html tiene como propietario al usuario root y el grupo root. Por lo tanto, tenemos que modificar esta configuración para que el propietario sea el usuario www-data y el grupo www-data.

<img width="763" height="46" alt="image" src="https://github.com/user-attachments/assets/66a36300-5d10-4562-bf50-67ea5e56c769" />

# Paso 7. Configuración de los enlaces permanentes o permalinks

Para configurar los enlaces permanentes con el nombre de las entradas podemos utilizar el siguiente comando.

<img width="691" height="122" alt="image" src="https://github.com/user-attachments/assets/860781b0-f782-4f7e-b571-a11b1e4c4805" />
