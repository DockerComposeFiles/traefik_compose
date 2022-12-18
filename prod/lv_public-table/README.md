# table

## commands

docker compose run --rm composer update
docker compose run --rm php artisan key:generate

docker compose run --rm artisan migrate:status
docker compose run --rm artisan migrate:fresh

docker compose run --rm npm update
docker compose run --rm npm install
docker compose run --rm npm run dev
docker compose run --rm npm run build
docker compose run --rm npm run production
