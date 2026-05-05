FROM ghcr.io/thedevs-cz/php:8.5

RUN rm -f /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y \
        libreoffice \
    && curl -sL https://sentry.io/get-cli/ | bash \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
