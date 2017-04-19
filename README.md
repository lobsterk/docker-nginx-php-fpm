# docker-web-server

## Overview

This is a Dockerfile/image to build a container ubuntu:16.04 for nginx and php-fpm, with php modules. and also  Node.js, npm.

| Docker Tag 	| GitHub Release 	| Nginx Version 	| PHP Version 	| Node js       | npm        	|
|------------	|----------------	|---------------	|-------------	|-------------	| -------------	|
| latest     	| Master Branch  	| 1.10.0        	| 7.0.15      	| 4.2.6         | 3.5.2      	|


List PHP modules:
```
[PHP Modules]
amqp bcmath calendar Core ctype curl date  dom exif fileinfo filter ftp gd gettext gmp hash
iconv intl json ldap libxml mbstring mcrypt mongodb mysqli mysqlnd openssl pcntl pcre PDO
pdo_mysql Phar posix readline Reflection session shmop SimpleXML soap sockets SPL standard 
sysvmsg sysvsem sysvshm tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl Zend OPcache zip zlib
[Zend Modules]
Zend OPcache
```
Addition:

`mc postfix`

## Links 
[Docker hub](https://hub.docker.com/r/lobsterk/nginx-php-fpm7.0/)

## Quick Start

To pull from docker hub:

`docker pull lobsterk/nginx-php-fpm7.0`

### Running
##### Simple run project 
```     
docker run -d -p 8080:80 \
      --rm \
      -v $(pwd)/www/:/var/www/html/ \
      --name test-docker \
      lobsterk/nginx-php-fpm7.0
```

##### Run project with nginx and php-fpm configs
```     
docker run -d -p 8080:80 \
      --rm \
      -v $(pwd)/www/:/var/www/html/ \
      -v $(pwd)/php-fpm/php.ini:/etc/php/7.0/fpm/php.ini \
      -v $(pwd)/php-fpm/php-fpm.conf:/etc/php/7.0/fpm/php-fpm.conf \
      -v $(pwd)/nginx/default.conf:/etc/nginx/conf.d/default.conf \
      -v $(pwd)/nginx/nginx.conf/:/etc/nginx/nginx.conf/ \
      --name test-docker \
      lobsterk/nginx-php-fpm7.0
```



##### Enter container bash

`docker exec -it test-docker /bin/bash`