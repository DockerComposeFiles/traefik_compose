services:
  app:
    image: bitnami/laravel:latest
    volumes:
      - ./:/app
    ports:
      - 8000:8000
    environment:
      - ALLOW_OVERRIDE=true
      - PHP_ERROR_REPORTING=E_ALL
  mariadb:
    image: mariadb:10.4
    volumes:
      - ./mariadb:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=password
      - MYSQL_DATABASE=laravel
      - MYSQL_USER=laravel
      - MYSQL_PASSWORD=laravel
