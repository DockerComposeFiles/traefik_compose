# FROM php:8.1.8-fpm-alpine as stable
# RUN docker-php-ext-install pdo pdo_mysql

# FROM php:8.0.21-fpm-alpine as oldStable
# RUN docker-php-ext-install pdo pdo_mysql

#   Alpine and debian works
FROM php:8.1.10-fpm-alpine as stable
# FROM php:8.1.10-fpm-bullseye as stable
RUN docker-php-ext-install pdo pdo_mysql
