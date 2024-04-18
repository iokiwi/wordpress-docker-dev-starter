# WordPress Docker Dev Environment Starter

A starter docker environment for building and testing WordPress Plugins and Themes against.

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

3. Install any additional 3rd party plugins and themes
    ```bash
    ./install-deps.sh
    ```

4. Start the dev environment
    ```bash
    docker compose up
    ```

5. Access the site http://localhost:8080

## Services

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
git clone git@github.com:johnsmith/my-theme.git ./themes/my-theme
```

## Programatically requiring additional 3rd party themes and plugins

Any theme or plugin in ./themes or ./plugins are 'installed' and available for use in wordpress.

### WordPress Packagist

[WordPress Packagist](https://wpackagist.org/) is a project to utilise [composer](https://getcomposer.org/) to programatically manage and install wordpress plugins.

E.g.

```bash
composer require wpackagist-plugin/woocommerce
```

More information and installable plugins and themes on [WordPress Packagist](https://wpackagist.org/)

### Custom scripted installation

Though empty, the `install-deps.sh` script has been included as a suggested location to do any custom scripted installation of themes or plugins as required.

## Working with the Database via CLI

Firstly, source the database credentials.

```bash
source envs/dev.env
```

We can check what is set with

```bash
env | grep DB_
```

### Access the Database

Connect as WordPress db user
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

Or the import `./import-data.sh` script will search our systems

```bash
./import-data.sh
```

## Reset

```bash
docker compose down -v
```