# site-musique-docker
Images docker pour déployer le site de la musique https://musique-meyenheim.fr/

# Instructions

#. Créer un réseau Docker (ici on l'apellera site-musique)
#. Créer un container php que l'on connecte au réseau :
    docker run --net=site-musique --name=musique-php --net-alias=php -d php:fpm-alpine
#. Création d'un volume pour stocker les certificats
    docker volume create --name=musique-ssl
#. Récupération des certificats
    docker run -it --rm -p 443:443 -p 80:80 --name certbot \
        -v musique-ssl:/etc/letsencrypt \
        quay.io/letsencrypt/letsencrypt:latest certonly \
        -n --standalone -m paul.trehiou@gmail.com -d musique-meyenheim.fr --agree-tos
#. Créer le container nginx basé sur le Dockerfile
    docker run -v musique-ssl/live/home.nyanlout.re:/etc/nginx/ssl -d  -p 80:80 -p 443:443 site-musique
