FROM ghcr.io/thedevs-cz/php:8.5

ARG TARGETARCH
ARG TAILWIND_VERSION=v4.1.11

RUN rm -f /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y \
        libreoffice \
    && curl -sL https://sentry.io/get-cli/ | bash \
    && case "${TARGETARCH}" in \
         amd64) TW_ARCH="x64" ;; \
         arm64) TW_ARCH="arm64" ;; \
         *) echo "Unsupported TARGETARCH=${TARGETARCH}" >&2 && exit 1 ;; \
       esac \
    && curl -fsSLo /usr/local/bin/tailwindcss \
        "https://github.com/tailwindlabs/tailwindcss/releases/download/${TAILWIND_VERSION}/tailwindcss-linux-${TW_ARCH}" \
    && chmod +x /usr/local/bin/tailwindcss \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
