FROM php:5.6-fpm
# Install modules
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        openssl \
        libssl-dev \
        libcurl4-openssl-dev \
        libicu-dev \
        libxslt-dev \
        libmemcached-dev  \
        git \
    && docker-php-ext-install curl iconv mcrypt mbstring mysqli pdo pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-configure bcmath \
    && docker-php-ext-install bcmath \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-configure xsl \
    && docker-php-ext-install xsl \
    && pecl install apcu-4.0.11 \
    && pecl install redis \
    && pecl install mongo \
    && pecl install mongodb \
    && pecl install memcache \
    && pecl install memcached \
    && pecl install xdebug \
    && pecl install xhprof \
    && git clone --depth=1 git://github.com/phalcon/cphalcon.git \
    && cd cphalcon/build \
    && ./install \
    && docker-php-ext-enable  opcache apcu redis mongo mongodb memcache memcached phalcon xdebug xhprof

COPY php-fpm.conf /usr/local/etc/
COPY php.ini /usr/local/etc/php/
CMD ["php-fpm"]
