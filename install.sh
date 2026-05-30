#!/bin/sh
set -e

composer config --global allow-plugins.dealerdirect/phpcodesniffer-composer-installer true

composer install --ignore-platform-reqs --no-interaction

npm install
npm run build

cp .env.example .env || true

php artisan key:generate

sed -i 's/DB_HOST=127.0.0.1/DB_HOST=172.17.0.2/g' .env
sed -i 's/DB_DATABASE=.*/DB_DATABASE=tailadmin/g' .env
sed -i 's/DB_USERNAME=.*/DB_USERNAME=root/g' .env
sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=password/g' .env

php artisan migrate --force || true
