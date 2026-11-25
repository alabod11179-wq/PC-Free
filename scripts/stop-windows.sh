#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(dirname "$0")/.."
docker compose --env-file .env -f compose.yml down
echo "Windows container stopped. The named windows-data volume was kept."
