#!/bin/sh
set -e
# Initial setup
mix deps.get --only prod
mix compile

# Compile assets
cd assets
npm install
./node_modules/.bin/brunch build --production
cd ..

mix phx.digest

# Wait for Postgres to become available.
until psql -w -h db -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

# Potentially Set up the database
mix ecto.create
mix ecto.migrate

# Finally run the server
mix phx.server