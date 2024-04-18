#!/usr/bin/env bash

# Recursively search for .sql file in the current directory
sql_file=$(find . -type f -name "*.sql" | head -n 1)

if [ -n "$sql_file" ]; then
    echo "Sourcing credentials from envs/dev.env"
    source envs/dev.env

    echo "Found $sql_file attempting to import..."
    docker compose up -d db

    # TODO: Potetnially we can do something a lot smarter than a sleep such
    # as poll the status of the container.
    for i in {1..5}
    do
        echo "Waiting for database to start ($i/5)..."
        docker compose ps db
        sleep 3
    done

    echo "Attempt to import $sql_file..."
    docker compose exec -T db mysql -u root -p$DB_ROOT_PASSWORD $DB_NAME < "$sql_file"

    echo "Shutting down database"
    docker compose down db
else
    echo "No SQL files found. Skipping import-data step..."
fi
