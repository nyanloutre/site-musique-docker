FROM php:fpm-alpine 

# Installations extentions necessaires
RUN docker-php-ext-install -j4 gd mysqli pdo pdo_mysql
RUN apk --update add freetype-dev
