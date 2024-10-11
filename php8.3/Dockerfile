FROM dunglas/frankenphp:php8.3

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_MEMORY_LIMIT=-1 \
    COMPOSER_HOME="/.composer"

COPY wait-for-it.sh /usr/local/bin/wait-for-it

RUN chmod +x /usr/local/bin/wait-for-it \
    && mkdir -p /.composer \
    && apt-get update && apt-get install -y \
        git \
        zip \
        ca-certificates \
        curl \
        lsb-release \
        gnupg \
        wget \
        nano \
        libmagickwand-dev \
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
        xsl \
    && git clone https://github.com/Imagick/imagick.git --depth 1 /tmp/imagick \
        && cd /tmp/imagick \
        && phpize \
        && ./configure \
        && make \
        && make install \
        && rm -rf /tmp/imagick \
        && docker-php-ext-enable imagick \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
