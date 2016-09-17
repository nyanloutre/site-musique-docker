# site-musique-docker
Images docker pour déployer le site de la musique https://musique-meyenheim.fr/

# Instructions

1. Création d'un volume pour stocker les certificats
```
docker volume create --name=musique-ssl
```
2. Récupération des certificats
```
docker run -it --rm -p 443:443 -p 80:80 --name certbot \
    -v musique-ssl:/etc/letsencrypt \
    quay.io/letsencrypt/letsencrypt:latest certonly \
    -n --standalone --agree-tos --rsa-key-size 4096 \
    -m paul.trehiou@gmail.com -d musique-meyenheim.fr
```
3. Créer un réseau Docker (ici on l'apellera site-musique)
4. Créer le container nginx basé sur le Dockerfile
```
docker create --name=musique-nginx --net=site-musique -v musique-ssl:/etc/nginx/ssl -v /usr/share/nginx/html -p 80:80 -p 443:443 nyanloutre/site-musique-docker
```
5. Créer un container php que l'on connecte au réseau
```
docker run --net=site-musique --name=musique-php --net-alias=php --volumes-from musique-nginx -d nyanloutre/site-musique-php
```
7. Créer un volume pour la base de donnée
```
docker volume create --name=musique-sql
```
6. Démarer un container mariaDB
```
docker run --name musique-mariadb --net=site-musique --net-alias=sql -v musique-sql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mariadb
```
7. Démarer le container nginx
```
docker start musique-nginx
```


# Installer un nouveau certificat en cas d'expiration

```
docker run -it --rm -p 443:443 -p 80:80 --name certbot \
    -v musique-ssl:/etc/letsencrypt \
    quay.io/letsencrypt/letsencrypt:latest renew -n
```

# Dumper la BDD
```
docker exec musique-mariadb sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > /some/path/on/your/host/all-databases.sql
```
