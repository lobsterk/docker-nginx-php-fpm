# docker web server

## Image versions

| Image Version | Base Image Version    | Nginx Version         | PHP Version   | Composer Ver | Nodejs Ver | NPM Ver  |
|---------------|-----------------------|-----------------------|---------------|--------------|------------|----------|
| 2.0.0         | Ubuntu 20.04          | 1.18.0                | 7.4.3         | 2.0.9        | 15.7.0     | 7.4.3    |



List PHP modules:
```
[PHP Modules]
amqp bcmath calendar Core ctype curl date  dom exif fileinfo filter ftp gd gettext gmp hash
iconv intl json ldap libxml mbstring mcrypt mongodb mysqli mysqlnd openssl pcntl pcre PDO
pdo_mysql Phar posix redis readline Reflection session shmop SimpleXML soap sockets SPL standard 
sysvmsg sysvsem sysvshm tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl Zend OPcache zip zlib
[Zend Modules]
Zend OPcache
```
Addition:

`git mc curl`


##### Simple run project 
```
docker run -d -p 8080:80 \
      --rm \
      -v $(pwd)/www/:/var/www/public/ \
      --name docker-nginx-php-fpm \
      lobsterk/web-nginx-php
```

##### Run project with docker compose 
```     
version: '3'

### Services
services:
  ### Web Server Container
  web:
    image: lobsterk/web-nginx-php
    container_name: web
    restart: always
    ports:
      - "8172:80"
    volumes:
      - ./www:/var/www/public
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf
      - ./php-fpm/php.ini:/etc/php/7.4/fpm/php.ini
      - ./php-fpm/php-fpm.conf:/etc/php/7.4/fpm/php-fpm.conf

```

##### Enter container bash

`docker exec -it test-docker /bin/bash`
