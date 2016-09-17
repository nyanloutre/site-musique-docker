# site-musique-docker
Images docker pour déployer le site de la musique https://musique-meyenheim.fr/

# Instructions

1. Créer un réseau Docker (ici on l'apellera site-musique)
2. Créer un container php que l'on connecte au réseau
```
docker run --net=site-musique --name=musique-php --net-alias=php -d php:fpm-alpine
```
3. Création d'un volume pour stocker les certificats
```
docker volume create --name=musique-ssl
```
4. Récupération des certificats
```
docker run -it --rm -p 443:443 -p 80:80 --name certbot \
    -v musique-ssl:/etc/letsencrypt \
    quay.io/letsencrypt/letsencrypt:latest certonly \
    -n --standalone --agree-tos --rsa-key-size 4096 \
    -m paul.trehiou@gmail.com -d musique-meyenheim.fr
```
5. Créer le container nginx basé sur le Dockerfile
```
docker run --name=musique-nginx --net=site-musique -v musique-ssl:/etc/nginx/ssl -d -p 80:80 -p 443:443 nyanloutre/site-musique-docker
```

# Installer un nouveau certificat en cas d'expiration

```
docker run -it --rm -p 443:443 -p 80:80 --name certbot \
    -v musique-ssl:/etc/letsencrypt \
    quay.io/letsencrypt/letsencrypt:latest renew -n
```
