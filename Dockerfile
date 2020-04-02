FROM ubuntu:latest
WORKDIR /usr/src/app
RUN sudo apt install wget php-cli php-zip unzip
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN HASH="$(wget -q -O - https://composer.github.io/installer.sig)"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
COPY ./Laravel ./Laravel
COPY ./Vue ./Vue
