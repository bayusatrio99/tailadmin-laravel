FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    apache2 \
    php \
    php-cli \
    php-curl \
    php-mysql \
    php-xml \
    php-mbstring \
    php-gd \
    unzip \
    curl \
    git \
    npm && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY . .

RUN chmod +x install.sh && ./install.sh

EXPOSE 8090

CMD php artisan serve --host=0.0.0.0 --port=8090
