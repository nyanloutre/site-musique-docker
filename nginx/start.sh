[ -f /etc/nginx/ssl/dhparam.pem ] || openssl dhparam -out /etc/nginx/ssl/dhparam.pem 4096
nginx -g "daemon off;"
