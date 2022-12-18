# FROM nginx:latest

# RUN adduser -D -H -u 1000 -s /bin/bash -G www-data www-data

# Soll nur eingebunden werden
# COPY ../src /var/www

FROM nginx:stable-alpine


RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

