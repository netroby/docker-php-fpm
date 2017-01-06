FROM php:7.0-fpm
# Install modules
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libicu-dev \
        libxslt-dev \
        libmemcached-dev  \
        git \
        openssl \
    && docker-php-ext-install sockets \
    && docker-php-ext-install curl iconv mcrypt mbstring mysqli pdo pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-configure bcmath \
    && docker-php-ext-install bcmath \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-configure xsl \
    && docker-php-ext-install xsl \
    && pecl install apcu \
    && pecl install yaf \
    && pecl install redis \
    && pecl install mongodb \
    && pecl install xdebug \
    && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
    && cd /usr/src/php/ext/memcached && git checkout -b php7 origin/php7 \
    && git clone --depth=1 git://github.com/phalcon/cphalcon.git /usr/src/php/ext/cphalcon \
    && cd /usr/src/php/ext/cphalcon/build \
    && ./install \
    && docker-php-ext-configure memcached \
    && docker-php-ext-install memcached \
    && docker-php-ext-enable  opcache apcu yaf redis mongodb phalcon xdebug

COPY php-fpm.conf /usr/local/etc/
COPY php.ini /usr/local/etc/php/
CMD ["php-fpm"]


COPY php-fpm.conf /usr/local/etc/
COPY php.ini /usr/local/etc/php/
CMD ["php-fpm"]
