# LuCLI With Docker and Nginx

Just an experiment to see how easy to do this.

This repository verifies how [LuCLI](docs/lucli.md) can power a Lucee CFML site from the command line and from Docker. It contains a tiny CFML app in `www/` plus the Docker assets required to run Lucee behind Nginx.

> LuCLI (/ˈluː-siː ˈɛl ˈaɪ/ — “Lucee-EL-EYE”) runs Lucee, manages servers, and executes CFML straight from your terminal. It delivers an interactive Lucee-powered REPL, one-shot commands, and simple server management without the bloat. Learn more at [lucli.dev](https://lucli.dev/).

## Requirements
- Java 17+ (to run `lucli.jar` directly)
- Docker + Docker Compose (to run the provided containers)
- `curl` (or similar) so you can download `lucli.jar` when needed

## Download LuCLI
Grab the latest LuCLI jar from GitHub releases (ignored by git so you can swap versions freely). This file must exist before building Docker images or running the CLI directly.

```bash
curl -L -o lucli.jar \
  https://github.com/cybersonic/LuCLI/releases/latest/download/lucli.jar
```

## Quick Start (LuCLI directly)
```bash
# enter the project directory
cd /path/to/lucli_test

# run the CFML server on port 8080 and serve ./www
LUCLI_HOME=$PWD/.lucli_home \
java -jar lucli.jar server run --port 8080 --webroot $PWD/www
```
Browse to http://localhost:8080 to see `www/index.cfm`.

## Quick Start (Docker + Nginx)
```bash
# builds a Docker image that embeds your checked-in lucli.jar and starts Lucee
docker compose up --build -d

# follow both containers
docker compose logs -f
```
This starts two services:
1. `lucee` – builds from `docker/lucli/Dockerfile`, copies in the local `lucli.jar`, and runs `java -jar lucli.jar server run --port 8080 --webroot /var/www`. Optionally override the jar during build via `docker compose build --build-arg LUCLI_JAR_URL=https://… lucee`.
2. `nginx` – serves static assets directly and proxies `.cfm/.cfc` requests to `lucee:8080` via `docker/nginx/default.conf`.

Stop everything with `docker compose down`. Re-run `docker compose build lucee` whenever you replace `lucli.jar`.

## Project Layout
```
.
├── docker/                 # Docker build context
│   ├── lucli/              # LuCLI Dockerfile + entrypoint
│   └── nginx/              # Nginx config used by docker-compose
├── docs/lucli.md           # Upstream LuCLI documentation
├── docker-compose.yml      # Lucee + Nginx stack definition
├── www/                    # CFML webroot served by LuCI/Nginx
│   ├── index.cfm
│   ├── lucee.json
│   └── WEB-INF/...
└── README.md
```

## Troubleshooting
- **502 Bad Gateway**: Ensure the LuCI service is listening on 8080 and restart with `docker compose restart lucee nginx`.
- **Port already in use**: Adjust `LUCLI_PORT` (for direct runs) or the `lucee` service environment variables and matching Nginx upstream.
- **Large jar missing**: Download `lucli.jar` into the repo root whenever you clone; both the direct-run commands and Docker build expect to find that file (Docker can alternately download via `LUCLI_JAR_URL` if the URL is accessible).

For full CLI reference and advanced configuration tips, see [docs/lucli.md](docs/lucli.md).
