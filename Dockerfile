FROM php:7.1-fpm-stretch

RUN apt-get update && apt-get install --no-install-recommends -y \
      ghostscript \
      imagemagick \
      libicu-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      libmcrypt-dev \
      libpq-dev \
      libxslt-dev \
      unzip \
    && pecl channel-update pecl.php.net \
    && pecl install apcu imagick redis \
    && docker-php-ext-enable apcu imagick redis \
    && docker-php-ext-configure intl --with-icu-dir=/usr \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install bcmath bz2 calendar exif gd intl mcrypt mysqli opcache pdo_mysql pdo_pgsql xsl zip \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && php -r "copy('https://getcomposer.org/composer.phar', 'composer.phar');" \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer
