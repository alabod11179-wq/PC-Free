#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(dirname "$0")/.."

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker CLI is not available in this Codespace."
  echo "Open a Codespace with Docker support, then try again."
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "Docker Compose plugin is missing. This setup needs 'docker compose'."
  exit 1
fi

if [ ! -f .env ]; then
  if ! command -v openssl >/dev/null 2>&1; then
    echo "OpenSSL is needed to create a private Windows password."
    exit 1
  fi
  WIN_PASS="$(openssl rand -hex 18)"
  umask 077
  printf 'WINDOWS_USERNAME=PCUser\nWINDOWS_PASSWORD=%s\n' "$WIN_PASS" > .env
  echo "Created a private .env file and generated a random Windows password."
  echo "Keep this password private. It will not be committed to GitHub."
fi

chmod 600 .env 2>/dev/null || true

echo "Checking Docker daemon..."
docker info >/dev/null

if [ -c /dev/kvm ] && [ -r /dev/kvm ] && [ -w /dev/kvm ]; then
  echo "KVM device detected. Trying hardware acceleration."
  docker compose --env-file .env -f compose.yml -f compose.kvm.yml up -d
else
  echo "No accessible /dev/kvm detected. Using software emulation (may be extremely slow)."
  docker compose --env-file .env -f compose.yml up -d
fi

echo
echo "Windows container start requested."
echo "Wait for installation, then open port 8006 from the Codespace Ports tab."
echo "Keep port 8006 PRIVATE. Do not change it to Public."
echo
docker compose --env-file .env ps
echo
echo "To view startup logs: docker compose --env-file .env logs -f windows"
