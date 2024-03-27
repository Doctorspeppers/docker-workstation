FROM php:8.2-fpm


RUN apt-get update && apt-get install bash
RUN apt-get update && apt-get install -y \
        libwebp-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        wget \
        zlib1g-dev \
        libpng-dev \
        libjpeg-dev \
        libzip-dev \
        git \
        zip \
        unzip \
        libmagickwand-dev \
        imagemagick
RUN docker-php-source extract \
	&& docker-php-source delete \
    && docker-php-ext-configure gd  \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable gd \
    && docker-php-ext-install zip \
    && docker-php-ext-configure zip \
    && docker-php-ext-enable zip \
    && docker-php-ext-install xml \
    && docker-php-ext-configure xml \
    && docker-php-ext-enable xml \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure pdo_mysql \
    && docker-php-ext-enable pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-configure mysqli \
    && docker-php-ext-enable mysqli \
    && docker-php-ext-install exif \
    && docker-php-ext-configure exif \
    && docker-php-ext-enable exif

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html/
