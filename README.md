# docker-web-server

`docker build -t lobsterk/nginx-php-fpm7.0:v.10 .`



```docker run -d -p 8080:80 -v `pwd`/www/:/var/www/html/ --name test-docker lobsterk/nginx-php-fpm7.0```