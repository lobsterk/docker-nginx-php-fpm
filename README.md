# docker web server

## Image versions

| Image Version | Base Image Version    | Nginx Version         | PHP Version   | Composer Ver | Nodejs Ver | NPM Ver  |
|---------------|-----------------------|-----------------------|---------------|--------------|------------|----------|
| 1.0.0         | Ubuntu 20.04          | 1.18.0                | 7.4.3         | 2.0.9        | 15.7.0     | 7.4.3    |



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

`git mc curl postfix`


##### Simple run project 
```
docker run -d -p 8080:80 \
      --rm \
      -v $(pwd)/www/:/var/www/ \
      --name test-docker \
      lobsterk/web-nginx-php
```

##### Run project with nginx and php-fpm configs
```     
docker run -d -p 8080:80 \
      --rm \
      -v $(pwd)/www/:/var/www/ \
      -v $(pwd)/php-fpm/php.ini:/etc/php/7.3/fpm/php.ini \
      -v $(pwd)/php-fpm/php-fpm.conf:/etc/php/7.3/fpm/php-fpm.conf \
      -v $(pwd)/nginx/default.conf:/etc/nginx/conf.d/default.conf \
      -v $(pwd)/nginx/nginx.conf/:/etc/nginx/nginx.conf/ \
      --name test-docker \
      lobsterk/web-nginx-php
```

##### Enter container bash

`docker exec -it test-docker /bin/bash`
