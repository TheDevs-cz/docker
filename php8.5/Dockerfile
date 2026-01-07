FROM dunglas/frankenphp:php8.5

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_MEMORY_LIMIT=-1 \
    COMPOSER_HOME="/.composer" \
    PHP_OPCACHE_VALIDATE_TIMESTAMPS=1 \
    PHP_OPCACHE_MAX_ACCELERATED_FILES=15000 \
    PHP_OPCACHE_MEMORY_CONSUMPTION=192 \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE=10 \
    SERVER_NAME=:80 \
    FRANKENPHP_WORKER="" \
    FRANKENPHP_WORKER_FILE="/app/public/index.php" \
    FRANKENPHP_WORKER_NUM="" \
    FRANKENPHP_WATCH="" \
    FRANKENPHP_WATCH_PATHS="./src/**/*.php ./config/**/*.{yaml,yml} ./templates/**/*.twig" \
    FRANKENPHP_CONFIG=""

COPY wait-for-it.sh /usr/local/bin/wait-for-it

RUN chmod +x /usr/local/bin/wait-for-it /usr/local/bin/docker-entrypoint \
    && mkdir -p /.composer /docker-entrypoint.d /etc/frankenphp/Caddyfile.d /data \
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
        imagick \
        excimer \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
COPY Caddyfile /etc/caddy/Caddyfile
COPY php.ini /usr/local/etc/php/conf.d/99-app.ini

ENTRYPOINT ["docker-entrypoint"]
CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
