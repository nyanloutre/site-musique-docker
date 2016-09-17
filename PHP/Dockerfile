FROM php:fpm-alpine 

# Installations extentions necessaires
RUN apk --update add freetype-dev freetype && \
    docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ && \
    docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) gd mysqli pdo pdo_mysql && \
    apk del --no-cache freetype-dev
