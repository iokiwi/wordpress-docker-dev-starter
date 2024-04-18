#!/usr/bin/env bash

export WORDPRESS_TAG=${1:-"6.4-php8.3"}


# Source the varibales eary otherwise the buils stage complains about values
# not being set even though it shouldn't make a difference.
source envs/dev.env
docker compose pull

./build.sh "$WORDPRESS_TAG"
./install-deps.sh
./import-data.sh

echo "Starting stack..."
docker compose up -d

echo
echo "Access:"
echo "  WordPress.....http://localhost:8080"
echo "  PhpMyAdmin....http://localhost:8081"

echo
echo "Stop:"
echo "  docker compose down"
echo "Logs:"
echo "  docker compose logs -f"
