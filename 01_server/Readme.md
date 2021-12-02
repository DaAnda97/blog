## Traefik

1. Create certificate database
   ``` bash
   touch acme.json
   chmod 600 acme.json
   ```

1. Set credentials:
   ``` bash
   apt install apache2-utils -y
   echo "DOMAIN=<YOUR_DOMAIN>" > .env
   echo "EMAIL=<YOUR_MAIL>" >> .env
   echo "COMPOSE_PROJECT_NAME=server" >> .env
   echo "TRAEFIK_CREDS=$(echo $(htpasswd -nb <USER> '<PASSWORD>'))" >> .env
   ```

1. Run the service
   ``` bash
   docker-compose up -d
   ```

