#!/usr/bin/env bash
################################# BEGIN CUSTOM SCRIPTS ##################################

echo "Installing plugins..."

# TODO: A custom install script to install any additional
# dependencies

# PLUGIN_VERSION=0.0.1
# echo "($PLUGIN_VERSION)   Plugin Name"
# curl -q https://archive.example.com/$PLUGIN_VERSION/plugin.zip -o plugins/plugin.zip
# unzip plugins/plugin.zip

echo "Installing themes..."


################################ END CUSTOM SCRIPTS ######################################
echo "Installing wpackagist dependencies..."
composer install
