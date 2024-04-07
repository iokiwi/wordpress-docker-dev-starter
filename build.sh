#!/usr/bin/env bash
WORDPRESS_TAG=${1:-"6.4-php8.3"}

docker compose build \
  --build-arg WORDPRESS_TAG="${WORDPRESS_TAG}" \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g) \
  wordpress
