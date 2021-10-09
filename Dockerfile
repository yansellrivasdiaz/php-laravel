FROM php:7.4.0-fpm-alpine

LABEL maintainer='Yansell Rivas <yansellrivasdiaz@gmail.com>'

 # Install dependencies
 RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev nano bash gzip && \
  docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include/ && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  docker-php-ext-install -j${NPROC} gd && \
  docker-php-ext-install exif && \
  docker-php-ext-enable exif && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev && \
  docker-php-ext-install pdo_mysql

COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./php.custom.ini /usr/local/etc/php/conf.d/php.custom.ini

CMD [ "php-fpm", "-R" ]
