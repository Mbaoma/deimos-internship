FROM php:7.4-apache

# Install PDO MySQL extension
RUN docker-php-ext-install pdo_mysql

#when running using different containers

COPY . /var/www/html/

# COPY .my.cnf /var/www/html/

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html

# RUN a2enmod rewrite

EXPOSE 80