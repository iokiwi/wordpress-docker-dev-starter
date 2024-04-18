#!/usr/bin/env bash
export WORDPRESS_TAG=${1:-"6.4-php8.3"}

echo "\$WORDPRESS_TAG=$WORDPRESS_TAG"

docker compose build \
  --build-arg WORDPRESS_TAG="${WORDPRESS_TAG}" \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g) \
  wordpress
