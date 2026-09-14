FROM ghcr.io/thedevs-cz/php:8.5

ARG TARGETARCH
ARG TAILWIND_VERSION=v4.1.11

ENV TAILWIND_BINARY=/usr/local/bin/tailwindcss

RUN rm -f /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y \
        libreoffice \
    && case "${TARGETARCH}" in \
         amd64) TW_ARCH="x64" ;; \
         arm64) TW_ARCH="arm64" ;; \
         *) echo "Unsupported TARGETARCH=${TARGETARCH}" >&2 && exit 1 ;; \
       esac \
    && curl -fsSLo /usr/local/bin/tailwindcss \
        "https://github.com/tailwindlabs/tailwindcss/releases/download/${TAILWIND_VERSION}/tailwindcss-linux-${TW_ARCH}" \
    && chmod +x /usr/local/bin/tailwindcss \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Make the fontconfig cache survive the image export. fc-cache validates each
# font dir by its mtime INCLUDING nanoseconds, but layer tars store whole
# seconds, so the caches apt built above go stale in the shipped image: the
# first soffice run in every container rescans ~300 MiB of fonts (charged to
# the app's cgroup as page cache — a one-off +475 MiB "leak" on lily, D62).
# Truncate every font dir's mtime to its own second (unchanged in the exported
# layer either way), then rebuild the caches against those values.
# Plain `for` loop: /bin/sh is dash (no `read -d`).
RUN FONT_DIRS="/usr/share/fonts /usr/local/share/fonts /usr/lib/libreoffice/share/fonts /usr/lib/libreoffice/program/resource/common/fonts" \
    && find $FONT_DIRS -type d -exec sh -c 'for d; do touch -m -d "@$(stat -c %Y "$d")" "$d"; done' sh {} + \
    && fc-cache -f \
    && fc-cache -f /usr/lib/libreoffice/share/fonts /usr/lib/libreoffice/program/resource/common/fonts
