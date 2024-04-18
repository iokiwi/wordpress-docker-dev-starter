# WordPress Docker Dev Environment Starter

A starter docker environment for building and testing WordPress Plugins and Themes against different versions of WordPress and PHP

## Quick Start

Setup up a full docker compose stack

```bash
./setup-all.sh
```

You can optionally request a specific version of WordPress and PHP
by providing the relevant [docker image tag](https://hub.docker.com/_/wordpress/tags).

```bash
./setup-all.sh 6.5-php8.3
```

For example `6.5-php8.3` will give us an image with WordPress 6.5 and php 8.3 if we want to test those specific versions.

## Step By Step

1. Source environment variables
    ```bash
    source envs/dev.env
    ```

2. Ensure user and group permission in container match host user and group to side step entre world of file permission pain.
    ```bash
    ./build.sh
    ```
    The version of PHP and WordPress can optionally be controlled via the `$WORDPRESS_TAG` variable (Default: `6.4-php8.3`) on both the script and the Dockerfile.

3. Install any additional 3rd party plugins and themes
    ```bash
    ./install-deps.sh
    ```

4. (Optional) Attempt to automatically discover any *.sql files and import them into the database.
    ```bash
    ./import-data.sh
    ```

5. Start the dev environment
    ```bash
    docker compose up
    ```

## Access to Services

|Service|URL|
|---|---|
|WordPress|http://localhost:8080|
|phpMyAdmin|http://localhost:8081|
|MySQL| `mysql://db:3306` or `mysql://localhost:3306`|

## Developing Plugins and Themes

Any valid theme or plugin located in ``./themes/`` or ``./plugins/`` will be available in the site.

A theme or plugin under development can be `git cloned` into `./theme` or `./plugin` respectively and worked on in place.

E.g.

```bash
git clone git@github.com:johnsmith/my-theme.git themes/my-theme
```

## Programatically requiring 3rd party themes and plugins

Any theme or plugin in ./themes or ./plugins are 'installed' and available for use in wordpress.

### A) WordPress Packagist

[WordPress Packagist](https://wpackagist.org/) is a project to utilise [composer](https://getcomposer.org/) to programatically manage and install wordpress plugins.

Wordpress plugins and themes available via Wordpress Packagist can be required and installed via composer.

```bash
composer require wpackagist-plugin/woocommerce
```

More information on [WordPress Packagist](https://wpackagist.org/)

### B) Custom scripted installation in install-deps.sh

Custom scripted installation of additional themes and plugins can be added to `install-deps.sh`.

The `install-deps.sh` script will also call the `composer install` command for us to install any packages listed in our `composer.json`

## Working with the Database via CLI

Firstly, source the database credentials.

```bash
source envs/dev.env
```

We can which variables are set with the `env` command

```bash
env | grep DB_
```

### Access the Database

Connect as WordPress system db user
```bash
docker compose exec db mysql -u $DB_USERNAME -p$DB_PASSWORD $DB_NAME
```
Connect as root user
```bash
docker compose exec db mysql -u root -p$DB_ROOT_PASSWORD
```

### Export

If the database container is running we can export with

```bash
docker compose exec db mysqldump -u root -p$DB_ROOT_PASSWORD --all-databases > dump.sql
```

### Import

```bash
docker compose exec -T db mysql -u root -p$DB_ROOT_PASSWORD $DB_NAME < dump.sql
```

Or the `./import-data.sh` helper script will search our repo for a `*.sql` file and import it into the database for us.

```bash
./import-data.sh
```

## Reset

```bash
docker compose down -v
```