FROM ubuntu:20.04

MAINTAINER Danil Kopylov <lobsterk@yandex.ru>

# install php 7.3
RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends --no-install-suggests && \
    apt-get install software-properties-common -y --no-install-recommends --no-install-suggests && \
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y && \
    apt-get update && \
    apt-get install php7.3-fpm php7.3-cli -y --no-install-recommends --no-install-suggests


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
    php-pear \
    php7.3-mongodb \
    php7.3-curl \
    php7.3-intl \
    php7.3-soap \
    php7.3-xml \
    php7.1-mcrypt \
    php7.3-bcmath \
    php7.3-mysql \
    php7.3-mysqli \
    php7.3-amqp \
    php7.3-mbstring \
    php7.3-ldap \
    php7.3-zip \
    php7.3-iconv \
    php7.3-pdo \
    php7.3-json \
    php7.3-simplexml \
    php7.3-xmlrpc \
    php7.3-gmp \
    php7.3-fileinfo \
    php7.3-sockets \
    php7.3-ldap \
    php7.3-gd \
    php7.3-redis \
    php7.3-xdebug && \
    echo "extension=apcu.so" | tee -a /etc/php/7.3/mods-available/cache.ini

# Install git core
RUN apt-get install -y --no-install-recommends --no-install-suggests \
    git-core

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Install node.js
RUN  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash \
&& export NVM_DIR="$HOME/.nvm" \
&& [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
&& nvm install node && nvm use node \
&& npm cache clean -f && npm install -g n && n stable && npm install cross-env

# Install mail server
COPY mailserver.sh /tmp/mailserver.sh
RUN /tmp/mailserver.sh

# set timezone Europe/Moscow
RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& ln -sf /dev/stderr /var/log/php7.3-fpm.log

RUN rm -f /etc/nginx/sites-enabled/*
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

COPY ./www/index.php /var/www/
RUN mkdir -p /run/php && touch /run/php/php7.3-fpm.sock && touch /run/php/php7.3-fpm.pid

COPY entrypoint.sh /entrypoint.sh

WORKDIR /var/www/
RUN chmod 755 /entrypoint.sh

EXPOSE 80
CMD ["/entrypoint.sh"]