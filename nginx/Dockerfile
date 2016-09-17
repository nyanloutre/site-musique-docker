FROM nginx:alpine
MAINTAINER Paul TREHIOU <paul.trehiou@gmail.com>

# Configure Nginx
COPY nginx-site.conf /etc/nginx/conf.d/default.conf

# Get the website content
RUN apk add git
RUN rm -rf /usr/share/nginx/html
RUN git clone https://github.com/nyanloutre/site-musique.git /usr/share/nginx/html

# Startup script
RUN apk add openssl
RUN mkdir /etc/nginx/ssl
COPY start.sh /start.sh

CMD ["/start.sh"]
