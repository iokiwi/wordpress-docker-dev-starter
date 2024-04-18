#!/usr/bin/env bash

export WORDPRESS_TAG=${1:-"latest"}

# Source the variables eary otherwise the build stage complains about values
# not being set even though it shouldn't make a difference.
source envs/dev.env
./build.sh "$WORDPRESS_TAG"

docker compose pull
./install-deps.sh
./import-data.sh

echo "Starting stack..."
docker compose up -d

echo
echo "Access:"
echo "  WordPress.....$WP_SITEURL"
echo "  PhpMyAdmin....http://localhost:8081"

echo
echo "Stop:"
echo "  docker compose down"
echo "Logs:"
echo "  docker compose logs -f [service]"
