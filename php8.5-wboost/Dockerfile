FROM ghcr.io/thedevs-cz/php:8.5

RUN rm -f /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y \
        inkscape \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
