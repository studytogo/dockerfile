FROM php:7.3-fpm AS build

# 更新加包
RUN apt-get update
RUN apt-get install -y libwebp-dev libjpeg-dev libpng-dev libfreetype6-dev

FROM build

EXPOSE 9000

#文件上传配置成20M
COPY uploads.ini /usr/local/etc/php/conf.d

RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN pecl install redis-4.2.0 && docker-php-ext-enable redis
RUN docker-php-ext-install bcmath
RUN docker-php-ext-configure gd  --with-webp-dir=/usr/include/webp --with-png-dir=/usr/include --with-jpeg-dir=/usr/include --with-freetype-dir=/usr/include/freetype2
RUN docker-php-ext-install gd