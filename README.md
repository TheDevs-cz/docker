# Docker base images

Images are built automatically using Github actions and pushed to Github Container Registry (ghcr.io).

Purpose of this repository is to speed up builds of other images.

## php8.5 (FrankenPHP)

FrankenPHP-based PHP 8.5 image with performance-optimized configuration.

### Features

- FrankenPHP with Caddy web server
- Worker mode support for high-performance applications
- File watching for development
- Optimized opcache settings
- Custom entrypoint with initialization hooks

### Entrypoint Configuration

The entrypoint script (`docker-entrypoint`) provides:

1. **Initialization scripts**: Place `.sh` scripts in `/docker-entrypoint.d/` to run before FrankenPHP starts. Scripts execute in alphabetical order:
   ```
   /docker-entrypoint.d/01-migrations.sh
   /docker-entrypoint.d/02-cache-warmup.sh
   ```

2. **Worker mode**: Automatically constructs FrankenPHP worker configuration from environment variables.

3. **File watching**: For development, enables automatic reload when files change.

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `SERVER_NAME` | `:80` | Caddy server address |
| `FRANKENPHP_WORKER` | (empty) | Set to `1` to enable worker mode |
| `FRANKENPHP_WORKER_FILE` | `/app/public/index.php` | Worker PHP file |
| `FRANKENPHP_WORKER_NUM` | (empty) | Number of worker processes |
| `FRANKENPHP_WATCH` | (empty) | Set to `1` to enable file watching |
| `FRANKENPHP_WATCH_PATHS` | `./src/**/*.php ./config/**/*.{yaml,yml} ./templates/**/*.twig` | Glob patterns to watch |
| `PHP_OPCACHE_VALIDATE_TIMESTAMPS` | `1` | Set to `0` in production |

### Usage Examples

**Development (with file watching):**
```yaml
services:
  app:
    image: ghcr.io/thedevs-cz/php8.5:latest
    environment:
      FRANKENPHP_WORKER: 1
      FRANKENPHP_WATCH: 1
    volumes:
      - .:/app
```

**Production (worker mode, no timestamp validation):**
```yaml
services:
  app:
    image: ghcr.io/thedevs-cz/php8.5:latest
    environment:
      FRANKENPHP_WORKER: 1
      FRANKENPHP_WORKER_NUM: 4
      PHP_OPCACHE_VALIDATE_TIMESTAMPS: 0
```

### PHP Extensions

bcmath, intl, pcntl, zip, uuid, pdo_mysql, pdo_pgsql, opcache, apcu, gd, exif, redis, xdebug, xsl, imagick, excimer

## php8.5-wboost

Extended PHP 8.5 image with Inkscape for PDF/SVG processing.

### Features

- Everything from `ghcr.io/thedevs-cz/php:8.5`
- Inkscape

### Usage

```yaml
services:
  app:
    image: ghcr.io/thedevs-cz/php:8.5-wboost
```

## php8.5-fajnesklady

Extended PHP 8.5 image with LibreOffice for document processing.

### Features

- Everything from `ghcr.io/thedevs-cz/php:8.5`
- LibreOffice

### Usage

```yaml
services:
  app:
    image: ghcr.io/thedevs-cz/php:8.5-fajnesklady
```
