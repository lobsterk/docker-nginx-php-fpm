FROM ubuntu:20.04

MAINTAINER Danil Kopylov <lobsterk@yandex.ru>

# install php 7.4
RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends --no-install-suggests && \
    apt-get install software-properties-common -y --no-install-recommends --no-install-suggests && \
    apt-get update && \
    apt-get install php7.4-fpm php7.4-cli -y --no-install-recommends --no-install-suggests


RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    nginx \
    ca-certificates \
    gettext \
    mc \
    libmcrypt-dev  \
    libicu-dev \
    libcurl4-openssl-dev \
    mysql-client \
    libldap2-dev \
    libfreetype6-dev \
    libfreetype6 \
    curl


# exts
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    php-common \
    php-mongodb \
    php-curl \
    php-intl \
    php-soap \
    php-xml \
    php-bcmath \
    php-mysql \
    php-amqp \
    php-mbstring \
    php-ldap \
    php-zip \
    php-json \
    php-xml \
    php-xmlrpc \
    php-gmp \
    php-ldap \
    php-gd \
    php-redis \
    php-xdebug && \
    echo "extension=apcu.so" | tee -a /etc/php/7.4/mods-available/cache.ini
#    php-mcrypt \

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Install node.js
RUN apt install -y gpg-agent && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt update && apt install -y nodejs yarn

# set timezone Europe/Moscow
RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& ln -sf /dev/stderr /var/log/php7.4-fpm.log

RUN rm -f /etc/nginx/sites-enabled/*
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

COPY ./www/index.php /var/www/public/
RUN mkdir -p /run/php && touch /run/php/php7.4-fpm.sock && touch /run/php/php7.4-fpm.pid

COPY entrypoint.sh /entrypoint.sh

WORKDIR /var/www/
RUN chmod 755 /entrypoint.sh

EXPOSE 80
CMD ["/entrypoint.sh"]
