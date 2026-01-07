#!/usr/bin/env bash

set -e

# Execute shell scripts from /docker-entrypoint.d/ if present
# This allows for custom initialization (e.g., Doctrine migrations)
# Scripts are executed in alphabetical order, so prefix with numbers for ordering:
#   /docker-entrypoint.d/01-migrations.sh
#   /docker-entrypoint.d/02-cache-warmup.sh

if /usr/bin/find "/docker-entrypoint.d/" -mindepth 1 -print -quit 2>/dev/null | /bin/grep -q .; then
    echo "$0: /docker-entrypoint.d/ is not empty, executing initialization scripts..."

    echo "$0: Looking for shell scripts in /docker-entrypoint.d/..."
    for f in $(/usr/bin/find /docker-entrypoint.d/ -type f -name "*.sh" | sort); do
        echo "$0: Launching $f";
        chmod +x "$f"
        "$f"
    done

    # Warn on file types we don't know what to do with
    for f in $(/usr/bin/find /docker-entrypoint.d/ -type f -not -name "*.sh"); do
        echo "$0: Ignoring $f (not a .sh file)";
    done

    echo
    echo "$0: Initialization complete; starting FrankenPHP..."
    echo
else
    echo "$0: /docker-entrypoint.d/ is empty, skipping initialization..."
fi

# Construct FRANKENPHP_CONFIG from helper environment variables
# Only if FRANKENPHP_CONFIG is not already set directly
if [ -z "${FRANKENPHP_CONFIG}" ] && [ "${FRANKENPHP_WORKER}" = "1" ]; then
    WORKER_FILE="${FRANKENPHP_WORKER_FILE:-/app/public/index.php}"

    # Build multi-line config (Caddyfile requires newlines in blocks)
    CONFIG="worker {
        file ${WORKER_FILE}"

    if [ -n "${FRANKENPHP_WORKER_NUM}" ]; then
        CONFIG="${CONFIG}
        num ${FRANKENPHP_WORKER_NUM}"
    fi

    if [ "${FRANKENPHP_WATCH}" = "1" ]; then
        # Default watch patterns - disable glob expansion to preserve patterns
        WATCH_PATHS="${FRANKENPHP_WATCH_PATHS:-./src/**/*.php ./config/**/*.{yaml,yml} ./templates/**/*.twig}"
        set -f  # Disable glob expansion
        for path in ${WATCH_PATHS}; do
            CONFIG="${CONFIG}
        watch ${path}"
        done
        set +f  # Re-enable glob expansion
    fi

    CONFIG="${CONFIG}
    }"
    export FRANKENPHP_CONFIG="${CONFIG}"
    echo "$0: Worker mode enabled"
fi

exec "$@"
