FROM ubuntu:16.04

MAINTAINER Danil Kopylov <lobsterk@yandex.ru>

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    nginx \
    php-fpm \
    ca-certificates \
    gettext \
    mc \
    libmcrypt-dev  \
    libicu-dev \
    make \
    gcc \
    libcurl4-openssl-dev \
    mysql-client \
    libldap2-dev \
    libfreetype6-dev \
    libfreetype6 \
    libpng12-dev


# exts
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    php-mongodb \
    php-curl \
    php-intl \
    php-soap \
    php-xml \
    php-mcrypt \
    php-bcmath \
    php-mysql \
    php-mysqli \
    php-amqp \
    php-mbstring \
    php-ldap \
    php-zip \
    php-iconv \
    php-pdo \
    php-json \
    php-simplexml \
    php-xmlrpc \
    php-gmp \
    php-fileinfo \
    php-sockets \
    php-ldap \
    php-gd \
    php-xdebug && \
    echo "extension=amqp.so" > /etc/php/7.0/cli/conf.d/10-amqp.ini && \
    echo "extension=amqp.so" > /etc/php/7.0/fpm/conf.d/10-amqp.ini && \
    rm -f /etc/php/7.0/mods-available/xdebug.ini \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install mail server
COPY mailserver.sh /tmp/mailserver.sh
RUN /tmp/mailserver.sh

# set timezone Europe/Moscow
RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& ln -sf /dev/stderr /var/log/php7.0-fpm.log

RUN rm -f /etc/nginx/sites-enabled/*
COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
#COPY php.ini /etc/php/7.0/fpm/php.ini


RUN mkdir -p /run/php && touch /run/php/php7.0-fpm.sock && touch /run/php/php7.0-fpm.pid
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
EXPOSE 80
CMD ["/entrypoint.sh"]