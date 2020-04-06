FROM php:7.4-fpm-alpine

WORKDIR /var/www

RUN docker-php-ext-install pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY --chown=www-data:www-data ./Laravel /var/www

RUN composer install
RUN php artisan key:generate

RUN apk add bash
RUN apk add mysql-client


COPY wait-for-mysql.sh /user/bin/wait-for-mysql.sh
RUN chmod +x /user/bin/wait-for-mysql.sh
CMD ["bash","-c","/user/bin/wait-for-mysql.sh && php artisan migrate:fresh && php-fpm"]