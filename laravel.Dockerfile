FROM composer:latest
COPY ./Laravel /app
WORKDIR /app
RUN docker-php-ext-install pdo_mysql
RUN composer install
RUN php artisan key:generate