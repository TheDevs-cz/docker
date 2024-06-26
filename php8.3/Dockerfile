FROM dunglas/frankenphp:php8.3

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_MEMORY_LIMIT=-1

RUN apt-get update && apt-get install -y \
        git \
        zip \
        ca-certificates \
        curl \
        lsb-release \
        gnupg \
        wget \
        nano \
    && install-php-extensions \
        @composer \
        bcmath \
        intl \
        pcntl \
        zip \
        uuid \
        pdo_mysql \
        pdo_pgsql \
        opcache \
        apcu \
        gd \
        exif \
        redis \
        xdebug \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
