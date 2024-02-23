# PHP 8.2 imajı kullan
FROM php:8.2-cli

# sqlite3 vb bagımlılıkları kur
RUN apt-get update \
    && apt-get install -y \
        git \
        unzip \
        libicu-dev \
        libsqlite3-dev \
        zlib1g-dev \
        libzip-dev \
    && rm -rf /var/lib/apt/lists/*

# Composer install 2.3.10 for symphony
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version="2.3.10"

# PHP extensions for sqlite3
RUN docker-php-ext-install pdo pdo_sqlite intl zip

# workdir
WORKDIR /app

# copy files and composer install
COPY . /app/
RUN composer install --no-dev --optimize-autoloader --no-interaction

#Port 8000
EXPOSE 8000

# PHP endpoint
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public/"]
