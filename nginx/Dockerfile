FROM nginx:alpine
MAINTAINER Paul TREHIOU <paul.trehiou@gmail.com>

# Startup script
RUN apk --update add openssl
RUN mkdir /etc/nginx/ssl
COPY start.sh /start.sh

# Configure Nginx
COPY nginx-site.conf /etc/nginx/conf.d/default.conf

# Get the website content
RUN apk --update add ca-certificates
RUN rm /usr/share/nginx/html/*
RUN wget https://github.com/nyanloutre/site-musique/archive/master.zip && unzip master.zip -d /usr/share/nginx/html && rm master.zip
RUN cd /usr/share/nginx/html && mv site-musique-master/* ./ && rmdir site-musique-master

CMD /start.sh
