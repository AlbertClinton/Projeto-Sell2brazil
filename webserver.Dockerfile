FROM nginx:stable-alpine
COPY /nginx.conf /etc/nginx/conf.d/default.conf

RUN apk add bash
RUN apk add curl

COPY wait-for-php-fpm.sh /user/bin/wait-for-php-fpm.sh
RUN chmod +x /user/bin/wait-for-php-fpm.sh
CMD ["bash","-c","/user/bin/wait-for-php-fpm.sh && nginx -g 'daemon off;'"]