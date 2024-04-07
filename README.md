# WordPress Docker Dev Environment Starter

A starter docker environment for building and testing WordPress Plugins and Themes against.

|||
|---|---|
|WordPress|http://localhost:8080|
|phpMyAdmin|http://localhost:8081|
|MySQL|`mysql://db:3306` or `mysql://localhost:3306`|

## WordPress Theme and Plugin Development

1. Ensure user and group permission in container match host user and group to side step entre world of file permission pain.
    ```bash
    ./build.sh
    ```
    The version of PHP and WordPress can optionally be controlled via the `$WORDPRESS_TAG` variable (Default: `6.4-php8.3`) on both the script and the Dockerfile.

2. Install additional plugins and themes from [WordPress Packagist](https://wpackagist.org/) via composer.
    ```bash
    composer install
    ```

3. Bring up the stack
    ```bash
    source envs/dev.env
    docker compose up
    ```

4. Access the site http://localhost:8080

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

[WordPress Packagist](https://wpackagist.org/) is a project to utilise [composer](https://getcomposer.org/) to programatically manage and install wordpress plugins and themes.

```bash
composer require wpackagist-plugin/woocommerce
```

Use the `wpackagist-plugin` or `wpackagist-theme` vendor prefix plus the name of any theme or plugin to install.

### Bash script

Though empty, the `install-deps.sh` script has been included as a suggested location to do any manual scripting of installation if desired


## Working with the Database via CLI

```bash
source envs/dev.env
```

### Access the Database

```bash
docker-compose exec db mysql -u $DB_USERNAME -p$DB_PASSWORD $DB_NAME
```
Connect as root

```bash
docker-compose exec db mysql -u root -p$DB_ROOT_PASSWORD
```

### Export

```bash
docker-compose exec db mysqldump -u root -p$DB_ROOT_PASSWORD --all-databases > dump.sql
```

### Import

```bash
docker-compose exec -T db mysql -u root -p$DB_ROOT_PASSWORD $DB_NAME < dump.sql
```

