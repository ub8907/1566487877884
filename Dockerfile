FROM php:8.0.2-apache
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y libzip-dev libxml2-dev libgmp-dev libsodium-dev libpng-dev vim --allow-unauthenticated

RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo pdo_mysql && docker-php-ext-install mysqli
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && apt-get install zip -y



COPY /app/app.zip /app/ 
WORKDIR /app
RUN ls
RUN unzip app.zip


RUN composer install

EXPOSE 8000
CMD php think run --host=0.0.0.0 --port=8000
