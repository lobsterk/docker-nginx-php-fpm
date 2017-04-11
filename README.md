# docker-web-server

- Build project

`docker build -t lobsterk/nginx-php-fpm7.0 .`


- Run project
```     
docker run -d -p 8080:80 \
      -v pwd/www/:/var/www/html/ \
      -v pwd/php.ini:/etc/php/7.0/fpm/php.ini \
      --name test-docker \
      lobsterk/nginx-php-fpm7.0:v.10
```

- Enter container bash

`docker exec -it test-docker /bin/bash`