FROM php:7.3-fpm
RUN useradd -ms /bin/bash www
# Install modules
RUN apt-get update && apt-get install -y \
        libevent-dev \
        libxml2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        imagemagick \
        libmagickwand-dev \
        libmcrypt-dev \
        libpng-dev \
        libcurl4-openssl-dev \
        libzip-dev \
        libssl-dev \
        libicu-dev \
        libxslt-dev \
        libmemcached-dev  \
        git \
        openssl \
        zlib1g-dev \
        wget  \
    && docker-php-ext-install sockets \
    && docker-php-ext-install curl iconv mbstring mysqli pdo pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-configure bcmath \
    && docker-php-ext-install bcmath \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-configure xsl \
    && docker-php-ext-install xsl \
    && pecl install apcu \
    && pecl install redis \
    && pecl install mongodb \
    && pecl install xdebug \
    && pecl install imagick \
    && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
    && docker-php-ext-configure memcached \
    && docker-php-ext-install memcached \
    && docker-php-ext-enable  opcache apcu redis mongodb xdebug imagick 


RUN curl -sS https://getcomposer.org/installer | php 
RUN    mv composer.phar /usr/local/bin/composer

RUN rm -rf /var/lib/apt/lists/*
COPY php-fpm.conf /usr/local/etc/
COPY php.ini /usr/local/etc/php/
CMD ["php-fpm"]


