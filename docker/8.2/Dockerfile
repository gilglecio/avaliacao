FROM php:8.2-cli

ARG WWWUSER=1000
ARG WWWGROUP=1000

WORKDIR /var/www/html

ENV TZ=America/Sao_Paulo

RUN apt-get update \
    && apt-get install -y --no-install-recommends git unzip libzip-dev default-mysql-client \
    && docker-php-ext-install pdo_mysql mysqli zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY php.ini /usr/local/etc/php/conf.d/99-app.ini

RUN groupadd --force -g $WWWGROUP app \
    && useradd -ms /bin/bash --no-user-group -g $WWWGROUP -u $WWWUSER app

USER app

EXPOSE 8000

CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
