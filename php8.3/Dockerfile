FROM dunglas/frankenphp:php8.3

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_MEMORY_LIMIT=-1

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
        git \
        zip \
        ca-certificates \
        curl \
        lsb-release \
        gnupg \
    && install-php-extensions \
        opcache \
        exif \
        bcmath \
        intl \
        pcntl \
        zip \
        pdo_mysql \
        apcu \
        gd
