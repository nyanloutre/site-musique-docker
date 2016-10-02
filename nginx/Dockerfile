FROM nginx:1.11.4-alpine
MAINTAINER Paul TREHIOU <paul.trehiou@gmail.com>

# Configure Nginx
COPY nginx-site.conf /etc/nginx/conf.d/default.conf

# Get the website content
RUN apk --update add ca-certificates openssl
RUN rm /usr/share/nginx/html/*
    
# Installing Piwik
RUN wget https://builds.piwik.org/piwik.zip && \
    unzip piwik.zip && \
    rm piwik.zip && \
    mkdir /usr/share/nginx/html/analytics && \
    mv /piwik/* /usr/share/nginx/html/analytics && \
    rmdir /piwik && \
    chmod 777 /usr/share/nginx/html/analytics/tmp && \
    chmod 777 /usr/share/nginx/html/analytics/config && \
    chmod 777 /usr/share/nginx/html/analytics/misc/user
